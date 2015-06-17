class ErrorsController < ApplicationController
 skip_before_action :verify_authenticity_token
	def routing
		params[:url]
    	render :file => "/public/404.html", :status => 404,:layout => false
	end
end
