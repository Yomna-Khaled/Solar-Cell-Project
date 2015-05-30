class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_filter :authenticate 
  before_filter :forgetpassword 

  def authenticate
      if !logged_in?
        redirect_to login_path
      end 
  end

    def forgetpassword
      if !logged_in?
        redirect_to forget_password_path
      end 

  end
end
