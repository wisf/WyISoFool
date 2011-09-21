class FeedController < ApplicationController
  def index
    @stories = Story.find :all,
                          :order => "created_at DESC"
    respond_to do |format|
      format.rss { render :layout => false } #index.rss.builder
    end
  end
end
