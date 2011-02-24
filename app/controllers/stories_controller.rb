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

    @stories = Story.paginate :conditions => @conditions,
                              :order => @order,
                              :per_page => 10,
                              :page => params[:page]

    respond_to do |format|
      format.html
      format.xml  { render :xml => @stories }
    end
  end

  def rate_up
    @story = Story.find(params[:id])
    @story.rate = @story.rate + 1
    @story.save
    session["story" + params[:id]] = true
    respond_to do |wants|
      wants.js do
        render :update do |page|
          page.replace_html "story" + params[:id], '<div class="ajaxanswer">Ваш голос принят</div>'
        end
      end
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

  # GET /stories/1
  # GET /stories/1.xml
  def show
    @story = Story.find(params[:id])

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
    @story.rate = 0

    respond_to do |format|
      if @story.save
        format.html { redirect_to "", :notice => 'Ваша история добавлена и появиться на сайте после одобрения модератором' }
        format.xml  { render :xml => @story, :status => :created, :location => @story }
      else
        format.html { redirect_to :controller => 'stories', :notice => "Вы не рассказали свою историю!" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
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
end
