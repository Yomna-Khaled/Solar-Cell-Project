class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_filter :authenticate 

  def authenticate
      if !logged_in?
        redirect_to login_path
      end 
  end
end
