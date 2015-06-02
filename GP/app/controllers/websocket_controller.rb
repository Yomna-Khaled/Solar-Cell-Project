class WebsocketController < WebsocketRails::BaseController
	def order
		puts "iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii"
		
		#task = Material.all
		task="yomna"
		puts "iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii"
		
      send_message :create_success, task, :namespace => :tasks
   
    	 puts "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"
     #  send_message :create_fail, task, :namespace => :tasks
    

	end
		
end
