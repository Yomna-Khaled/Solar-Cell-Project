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

  # GET /employees/1
  def show
  end

  # GET /employees/new
  def new

      if logged_in? and current_category.category=="HR"
       @flag_new=1 #display password field in from

      @employee = Employee.new
      else
        redirect_to login_path  
    end 
  end

  # GET /employees/1/edit
  def edit
    @flag_new=0
  end

  # POST /employees
  def create
    @employee = Employee.new(employee_params)
    if @employee.salary != nil

      @employee.houre_rate=@employee.salary/(26*8) #calculate hour_rate of employee
      @employee.salary=0.0
    end

    @employee.password=Digest::MD5.hexdigest(@employee.password) #convert password to md5 for security
    respond_to do |format|
      if @employee.save
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
    respond_to do |format|
      if @employee.update(employee_params)
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
      params.require(:employee).permit( :user_name, :salary, :education_level, :Governamental_ID, :position, :category_id, :crew_id, :image, :password , :full_name)
    end
end
