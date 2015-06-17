module SessionsHelper
		  # Logs in the given user.
    def log_in(employee)
      session[:user_id] = employee.id
    end

    # Returns the current logged-in user (if any).
    def current_user
      @current_user ||= Employee.find_by(id: session[:user_id])
    end

    def current_category
      @category ||= Category.find_by(id: current_user.category_id)
    end  
    
    def current_shift   
      @shift = Shift.find_by(id: session[:shift_id])
    end


    # Returns true if the user is logged in, false otherwise.
    def logged_in?
      !current_user.nil?
    end

    # Logs out the current user.
    def log_out
      session.delete(:user_id)
      session.delete(:vendortype)
      @current_user = nil
    end
end
