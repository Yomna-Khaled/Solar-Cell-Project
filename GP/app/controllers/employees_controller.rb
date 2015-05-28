class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  # GET /employees
  def index
    if logged_in? and current_category.category=="HR"
      @employees = Employee.all
    else
      redirect_to login_path  
    end   
  end
  def pho
	@employeephones_selected = EmployeePhone.where("phone = ?",params[:phone])
	@employeephones_selected[0].destroy
  end

  # GET /employees/1
  def show
    @employee_phones = EmployeePhone.where("employee_id=?",@employee.id)
  end

  # GET /employees/new
  def new
      if logged_in? and current_category.category=="HR"
       @flag_new=1 #display password field in from
       @flag="new"
      @employee = Employee.new
      else
        redirect_to login_path  
    end 
  end

  # GET /employees/1/edit
  def edit
    @flag="edit"
    @employee = Employee.find(params[:id])
    @phones = EmployeePhone.where("employee_id = ? ", @employee.id ).select([:phone])

    @flag_new=0
    @cat=Category.find_by(:id => @employee.category_id)
    @category_id=@cat.id
  end

  # POST /employees
  def create
    @employee = Employee.new(employee_params)
    if @employee.salary != nil
      @employee.houre_rate=@employee.salary/(26*8) #calculate hour_rate of employee
    end

    @employee.password=Digest::MD5.hexdigest(@employee.password) #convert password to md5 for security
    @employee.password_confirmation=Digest::MD5.hexdigest(@employee.password_confirmation)
    respond_to do |format|
      if @employee.save


          if params[:employee_phones][:phone]==" "
         @employeephone = EmployeePhone.new(phone: ' ', employee_id: @employee.id) 
         @employeephone.save  
        else
         arr= params[:employee_phones][:phone].split(",")
	 arr.each do |c|
		puts c	
           @employeephone = EmployeePhone.new(phone: c, employee_id: @employee.id) 
           @employeephone.save 
        end
        end 

        format.html { redirect_to @employee }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  def update
       @employee.houre_rate=@employee.salary/(26*8) 
       employee_params[:houre_rate] =  @employee.houre_rate
       respond_to do |format|
       
      if @employee.update(employee_params)

        arr= params[:employee_phones][:phone].split(",")
	 arr.each do |c|
		puts c	
           @employeephone = EmployeePhone.new(phone: c, employee_id: @employee.id) 
           @employeephone.save 
	 end 
        
     
        flash[:success] = 'Employee was successfully updated.'
        format.html { redirect_to @employee }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  def destroy
    @employee.destroy
    respond_to do |format|
      flash[:danger] = 'Employee was successfully destroyed.'
      format.html { redirect_to employees_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit( :user_name, :salary, :education_level , :education, :Governamental_ID,  :category_id, :crew_id, :image, :password , :full_name, :password_confirmation)
    end
     def phone_params
      params.require(:employee).permit(:phone)
    end
end
