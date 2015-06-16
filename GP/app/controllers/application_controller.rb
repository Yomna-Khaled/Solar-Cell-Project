class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

   skip_before_action :verify_authenticity_token
  rescue_from ActionController::RoutingError, :with => :render_404# Render 404 page when record not found
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  def render_404      
    render :file => "/public/404.html", :status => 404,:layout => false
  end


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


  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

end
