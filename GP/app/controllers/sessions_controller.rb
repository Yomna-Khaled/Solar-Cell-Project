class SessionsController < ApplicationController
   def new
    if logged_in?
      flash[:success] = 'You are already logged_in' # Not quite right!    
      redirect_to current_user
    end
  end

  def create
        if params[:session][:password] != ""
            puts "-----------------------------------------"
            puts params[:session][:password]
            password=Digest::MD5.hexdigest(params[:session][:password])
            @employee = Employee.find_by(user_name: params[:session][:user_name].downcase , password: password)
            if @employee
              # Log the user in and redirect to the user's show page.
              log_in @employee
              flash[:success] = 'Welcome' # Not quite right!
              redirect_to @employee
            else
              # Create an error message.
               flash[:danger] = 'Invalid name/password combination' # Not quite right!
               redirect_to login_path

            end
            else
               flash[:danger] = 'Invalid name/password combination'
               redirect_to login_path
        end

  end

  def destroy
    log_out
    redirect_to login_path
  end
  
end
