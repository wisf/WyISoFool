# encoding: UTF-8
class AdminController < ApplicationController
  def index
  end

  def signin    
    session[:user] = User.authenticate(params[:user][:username], params[:user][:password]).id
    redirect_to :back , :notice => "Добро пожаловать в мир дур, о всемогущий #{params[:user][:username]}!"
  end

  def signout
    session[:user] = nil
    redirect_to :back
  end

end