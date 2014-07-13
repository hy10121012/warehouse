class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include BrandsHelper

  before_filter :request_login



  def login!
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def request_login
    if !login!
      redirect_to "/";
    end


  end


end
