class UserNotifier < ApplicationMailer
	default from: "firstcompany.for.solarcell@gmail.com"
  def forget_password(employee,password)
  	@employee = employee
  	@password=password
    mail to: @employee.email,subject: "Forget Password"
  end
end
