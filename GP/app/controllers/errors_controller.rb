class ErrorsController < ApplicationController
	def routing
		params[:url]
		render :file => "/public/404.html", :status => 404
	end
end
