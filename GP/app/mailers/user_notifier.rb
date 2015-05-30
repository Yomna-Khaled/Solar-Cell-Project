class UserNotifier < ApplicationMailer
	default from: "meetup1000@gmail.com"
  def forget_password(employee,password)
  	@employee = employee
  	@password=password
    mail to: @employee.email,subject: "Forget Password"
  end
end
