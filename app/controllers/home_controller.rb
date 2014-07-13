class HomeController < ApplicationController
  layout "blank"
  skip_before_filter :request_login
  def login
    s = params[:login_status]
    if s=="failed"
      @status = "login failed, please try again"

    end
  end
  def loginCheck
    @post =  params[:user];
    @user = User.find_by_name_and_password(@post['name'],@post['password'])
    if @user.nil?
      redirect_to :action => "login",:login_status=>"failed";
    else
      session[:user_id]= @user.id;
      session[:auth_level]= @user.auth_level;
      redirect_to "/main";
    end

  end


end
