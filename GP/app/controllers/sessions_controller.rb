class SessionsController < ApplicationController
  skip_before_filter :authenticate
  skip_before_filter :forgetpassword 

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
        @employee = Employee.find_by(email: params[:session][:email].downcase , password: password)
        if @employee
          # Log the user in and redirect to the user's show page.
          log_in @employee
          if (current_category.category=="Shift Manager") 
              @shift=Shift.where("employee_id = ?", current_user.id ).where("end_shift_date IS NULL  AND end_shift_time IS NULL")        
              if @shift.exists?
	               session[:shift_id] = @shift[0].id
              end
          end
          flash[:success] = 'Welcome' # Not quite right!
          redirect_to @employee #action
        else
          # Create an error message.
           flash[:danger] = 'Invalid email/password combination' # Not quite right!
           redirect_to login_path
        end
        else
           flash[:danger] = 'Invalid email/password combination'
           redirect_to login_path
    end

  end

  def forget_password
      @employee = Employee.find_by(email: params[:email])
      if @employee
          @password=rand.to_s[2..7]
          password_md5=Digest::MD5.hexdigest(@password)
          Employee.where("email = ? ", @employee.email).update_all(:password =>  password_md5)
          UserNotifier.forget_password(@employee,@password).deliver
          flash[:success] = 'Check your mail to get the new password' # Not quite right!
          redirect_to login_path
      else
          flash[:danger] = 'Invalid Email' # Not quite right!
          redirect_to forget_password_path
      end        
  end 

 def forget_password_form
 end


 def destroy
    log_out
    redirect_to login_path
 end
  
end
