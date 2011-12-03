# encoding: UTF-8

class StoriesController < ApplicationController
  before_filter :require_login, :only => [ :edit, :update, :destroy, :aproove, :hide ]
  # GET /stories
  # GET /stories.xml
  def index
    session[:page] = params[:page]
    @order = 'created_at DESC'
    @conditions = ['content like ?', "%#{params[:s]}%"] if params[:s]
    if params[:order].present? and params[:order].eql?("best")
      @order = 'rate DESC'
    end

    dead_time = case params[:period]
                  when "week"  then Time.now - 1.week
                  when "month" then Time.now - 1.month
                end

    if session[:user].blank?
      if dead_time
        @conditions = ['content like ? AND aprooved = ? AND created_at >= ?', "%#{params[:s]}%", true, dead_time]
      else
        @conditions = ['content like ? AND aprooved = ?', "%#{params[:s]}%", true]
      end
    else
      if params[:order].blank?
        @order = "aprooved DESC, " + @order
      end
    end

    @stories = Story.paginate(
        :conditions => @conditions,
        :order => @order,
        :per_page => 8,
        :page => params[:page]
    )

    respond_to do |format|
      format.html
      format.xml  { render :layout => false }
    end
  end

  def rate_up
    @story = Story.find(params[:id])
    @story.rate = @story.rate + 1
    @story.save
    session["story" + params[:id]] = true
    respond_to do |format|
      format.js { render "rate_change" }
      format.html { redirect_to get_url }
    end
  end

  # GET /stories/rate_down/1
  def rate_down
    @story = Story.find(params[:id])
    @story.rate = @story.rate - 1
    @story.save
    session["story" + params[:id]] = true
    respond_to do |format|
      format.js { render "rate_change" }
      format.html { redirect_to get_url }
    end
  end

  def getPrev id
	i = id.to_i
	loop do
		i = i - 1
		break if (Story.where(["id = ?", i.to_s]).size > 0)
	end
	i.to_s
  end
  
  # GET /stories/1
  # GET /stories/1.xml
  def show
    @story = Story.includes(:comments).find(params[:id])
    @next = (@story.id.eql?(Story.last.id)) ? Story.first.id : Story.where(["id > ?", params[:id]]).limit(1)[0].id
    @prev = (@story.id.eql?(Story.first.id)) ? Story.last.id : getPrev(@story.id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /stories/1/edit
  def edit
    @story = Story.find(params[:id])
  end


  def any_free
    if User.authenticate(params[:username], params[:password])
      @story = Story.find_by_vk_label(false)
    end
    render 'stories/any_free', :layout => false
  end

  def vk_post
    if User.authenticate(params[:username], params[:password])
      @story = Story.find params[:id]
      p @story
      @story.vk_label = true
      @story.save
    end
    render :text => "Ok"
  end

  def find
    redirect_to :controller => 'stories' , :s => params[:s], :notice => 'Результаты поиска по запросу ' + params[:s]
  end

  # POST /stories
  # POST /stories.xml
  def create
    @story = Story.new(params[:story])
    @story.vk_label = false
    if (@story.content.include? "</") or (@story.content.include? "://")
      respond_to do |format|
        format.html { render :text => "<html><head><link href='/stylesheets/theme000.css' media='screen' rel='stylesheet' type='text/css'/><script>window.setTimeout('window.top.hidePopWin()', 10000);</script></head><body><p id='notice'>Пиздуй отсюда нахуй, ёбаный спамер</p><p style='text-align: center;'>Что за хуйню ты мне тут пишешь? А??? СУКА!!!</p><div style='text-align: center;'>" + params[:story][:content] + "</div><div style='width: 300; margin: 0px auto;'><input type='button' value='Скрыть (Автоскрытие в течении 10 секунд)' onclick='window.top.hidePopWin();' class='button'/></div><p style='text-align: center;'><a href='' onclick='window.top.hidePopWin();window.open(\"http://natribu.org/\");'>Пойти нахуй</a><p></body></html>" }
      end
    else
      @story.rate = 0

      if @story.author.blank?
        @story.author = "Аноним"
      end

      respond_to do |format|
        if @story.save
#      		Thread.new do
#      			User.all.each do |user|
#      				UserMailer.createstory_confirmation(@story, user).deliver
#      			end
#      		end
          format.html { render :text => "<html><head><link href='/stylesheets/theme000.css' media='screen' rel='stylesheet' type='text/css'/><script>window.setTimeout('window.top.hidePopWin()', 10000);</script></head><body><p id='notice'>Ваша история добавлена и появиться на сайте после одобрения модератором</p><div style='text-align: center;'>" + params[:story][:content] + "</div><div style='width: 300; margin: 0px auto;'><input type='button' value='Скрыть (Автоскрытие в течении 10 секунд)' onclick='window.top.hidePopWin();' class='button'/></div><p style='text-align: center;'><a href='' onclick='window.top.hidePopWin();window.open(\"" + story_path(@story) +"\");'>Перейти на страницу истории</a><p></body></html>" }
          format.xml  { render :xml => @story, :status => :created, :location => @story }
        else
          format.html { render :text => "<html><head><link href='/stylesheets/theme000.css' media='screen' rel='stylesheet' type='text/css'/><script>window.setTimeout('window.top.hidePopWin();', 10000);</script></head><body><div style='height: 150px;'></div><p id='notice'>Ваша история слишком коротка</p><div style='width: 300; margin: 0px auto;'><input type='button' value='Скрыть (Автоскрытие в течении 10 секунд)' onclick='window.top.hidePopWin();' class='button'/></div></body></html>" }
          format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /stories/1
  # PUT /stories/1.xml
  def update
    @story = Story.find(params[:id])

    respond_to do |format|
      if @story.update_attributes(params[:story])
        format.html { redirect_to(@story, :notice => 'Story was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.xml
  def destroy
    @story = Story.find(params[:id])
    @story.destroy

    respond_to do |format|
      format.html { redirect_to  :controller => 'stories', :notice => 'История №' + params[:id].to_s + ' была успешно запушена в космос)' }
      format.xml  { head :ok }
    end
  end

  def aproove
    @story = Story.find(params[:id])
    @story.aprooved = true
    @story.save

    respond_to do |format|
      format.html { redirect_to  :controller => 'stories', :notice => 'История №' + params[:id].to_s + ' была успешна опубликована' }
      format.xml  { head :ok }
    end
  end

  def hide
    @story = Story.find(params[:id])
    @story.aprooved = false
    @story.save

    respond_to do |format|
      format.html { redirect_to  :controller => 'stories', :notice => 'История №' + params[:id].to_s + ' была скрыта' }
      format.xml  { head :ok }
    end
  end

  def add_comment
		@comment = Comment.new(params[:comment])
    if @comment.author.blank?
      @comment.author = "Аноним"
    end
		@story = Story.find(params[:id])
		@comment.story = @story
    @saved = (@comment.save) and ((session["lastcommenttime"].blank?) or (Time.now - session["lastcommenttime"] > 60))
    if @saved
      Thread.new do
        User.all.each do |user|
          UserMailer.append_comment_notification(@comment, user).deliver
        end
      end
    end

    respond_to do |format|
      format.js
      format.html { redirect_to story_url @story }
    end
  end

  private

  def require_login
    if session[:user].blank?
      redirect_to :controller => :admin, :notice => "Вы должны быть зарегистрированы для выполнения данного действия"
    end
  end
end
