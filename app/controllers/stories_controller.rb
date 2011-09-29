# encoding: UTF-8
class StoriesController < ApplicationController
  # GET /stories
  # GET /stories.xml
  def index
    session[:page] = params[:page]
    @order = 'created_at DESC'
    @conditions = ['content like ?', "%#{params[:s]}%"]
    if !params[:order].blank?
      @order = 'rate DESC'
    end
    #@story = Story.new
    if !session[:user].blank? && params[:order].blank?
      @order = 'aprooved ASC, ' + @order
    else
      @conditions = ['content like ? AND aprooved = ?', "%#{params[:s]}%", true]
    end

    @stories = Story.paginate :include => :comments,
                              :conditions => @conditions,
                              :order => @order,
                              :per_page => 10,
                              :page => params[:page]

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
    respond_to do |wants|
      wants.js {
        render :update do |page|
          page.replace_html "story" + params[:id], "<div class='ajaxanswer'>Ваш голос принят</div>"
        end
      }
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
    @story = Story.find(params[:id])
	@next = (@story.id.eql?(Story.last.id)) ? Story.first.id : Story.where(["id > ?", params[:id]]).limit(1)[0].id
	@prev = (@story.id.eql?(Story.first.id)) ? Story.last.id : getPrev(@story.id)
	respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /stories/new
  # GET /stories/new.xml
#  def new
#    @story = Story.new

#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @story }
#    end
#  end

  # GET /stories/1/edit
  def edit
    @story = Story.find(params[:id])
  end

  def find
    redirect_to :controller => 'stories' , :s => params[:s], :notice => 'Результаты поиска по запросу ' + params[:s]
  end

  # POST /stories
  # POST /stories.xml
  def create
    @story = Story.new(params[:story])
    if @story.content.include? "</a>"
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
      		Thread.new do
      			User.all.each do |user|
      				UserMailer.createstory_confirmation(@story, user).deliver
      			end
      		end
      		storyPath = root_url + "stories/" + @story.id.to_s
          format.html { render :text => "<html><head><link href='/stylesheets/theme000.css' media='screen' rel='stylesheet' type='text/css'/><script>window.setTimeout('window.top.hidePopWin()', 10000);</script></head><body><p id='notice'>Ваша история добавлена и появиться на сайте после одобрения модератором</p><div style='text-align: center;'>" + params[:story][:content] + "</div><div style='width: 300; margin: 0px auto;'><input type='button' value='Скрыть (Автоскрытие в течении 10 секунд)' onclick='window.top.hidePopWin();' class='button'/></div><p style='text-align: center;'><a href='' onclick='window.top.hidePopWin();window.open(\"" + storyPath +"\");'>Перейти на страницу истории</a><p></body></html>" }
          format.xml  { render :xml => @story, :status => :created, :location => @story }
        else
          format.html { render :text => "<html><head><link href='/stylesheets/theme000.css' media='screen' rel='stylesheet' type='text/css'/><script>window.setTimeout('window.top.hidePopWin();', 10000);</script></head><body><div style='height: 150px;'></div><p id='notice'>Вы не рассказали свою историю!</p><div style='width: 300; margin: 0px auto;'><input type='button' value='Скрыть (Автоскрытие в течении 10 секунд)' onclick='window.top.hidePopWin();' class='button'/></div></body></html>" }
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
    if !session[:user].blank?
      @story = Story.find(params[:id])
      @story.destroy

      respond_to do |format|
        format.html { redirect_to  :controller => 'stories', :notice => 'История №' + params[:id].to_s + ' была успешно запушена в космос)' }
        format.xml  { head :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to  :controller => 'stories', :notice => 'Уважаемый, так называемый хакер, идите нахуй!' }
        format.xml  { head :ok }
      end
    end
  end

  def aproove
    if !session[:user].blank?
      @story = Story.find(params[:id])
      @story.aprooved = true
      @story.save

      respond_to do |format|
        format.html { redirect_to  :controller => 'stories', :notice => 'История №' + params[:id].to_s + ' была успешна опубликована' }
        format.xml  { head :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to  :controller => 'stories', :notice => 'Уважаемый, так называемый хакер, идите нахуй!' }
        format.xml  { head :ok }
      end
    end
  end
  def hide
    if !session[:user].blank?
      @story = Story.find(params[:id])
      @story.aprooved = false
      @story.save

      respond_to do |format|
        format.html { redirect_to  :controller => 'stories', :notice => 'История №' + params[:id].to_s + ' была скрыта' }
        format.xml  { head :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to  :controller => 'stories', :notice => 'Уважаемый, так называемый хакер, идите нахуй!' }
        format.xml  { head :ok }
      end
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
end
