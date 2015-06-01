class WebsocketController < WebsocketRails::BaseController
	def order
		task = 	Websocket.new message
		if task.save
      send_message :create_success, task, :namespace => :tasks
    else
      send_message :create_fail, task, :namespace => :tasks
    end

	end
		
end
