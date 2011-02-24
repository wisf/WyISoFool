# encoding: UTF-8
class AdminController < ApplicationController
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stories }
    end
  end

  def signin    
    session[:user] = User.authenticate(params[:user][:username], params[:user][:password]).id
    redirect_to :controller => 'stories' , :notice => 'Добро пожаловать в мир дур, о всемогущий ' + params[:user][:username] + '!'
  end

  def signout
    session[:user] = nil
    redirect_to :controller => 'stories'
  end

end