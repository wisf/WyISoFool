# encoding: UTF-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  def admin_auth
    redirect_to admin_path if session[:user].blank?
  end
end
