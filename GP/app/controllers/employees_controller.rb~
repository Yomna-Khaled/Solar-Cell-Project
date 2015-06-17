class EmployeesController < ApplicationController
   skip_before_action :verify_authenticity_token
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  # GET /employees
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404,:layout => false
  end

  def fire
     @employee=Employee.where("id= ?",params[:id]).update_all(:status => "no" )
     @employees = Employee.all
     @employees = Employee.paginate(:page => params[:page], :per_page => 6)
     render plain:"ok"
  end
  
  def search
    admin = Category.find_by(category: "Admin")
    if params[:type]=="current"
      @employees=Employee.where("status= ?","yes").where("category_id != ? " , admin.id )
      @employees = @employees.paginate(:page => params[:page], :per_page => 6)
      render partial: 'find'
    elsif params[:type]=="past"
      @employees=Employee.where("status= ?","no").where("category_id != ? " , admin.id )
      @employees = @employees.paginate(:page => params[:page], :per_page => 6)
      render partial: 'find'
    else
      @employees=Employee.all
      @employees = Employee.paginate(:page => params[:page], :per_page => 6)
      render partial: 'find'
    end
  end  
  
  def index
    if current_category.category=="HR" or current_category.category=="Admin"
      admin = Category.find_by(category: "Admin")
      @employees = Employee.where("category_id != ? " , admin.id ).paginate(:page => params[:page], :per_page => 6)
    else
      render :file => "/public/404.html",:status  => "404"
    end   
  end

  def pho
  	@employeephones_selected = EmployeePhone.where("phone = ?",params[:phone])
  	@employeephones_selected[0].destroy
  end

  # GET /employees/1
  def show
    if current_category.category=="HR" or @employee.id == current_user.id or current_category.category=="Admin"
      @employee_phones = EmployeePhone.where("employee_id=?",@employee.id)
    else
      render :file => "/public/404.html",:status  => "404" 
    end
  end

  # GET /employees/new
  def new
    if current_category.category=="HR"
      @flag_new=1 #display password field in from
      @flag="new"
      @employee = Employee.new
    else
      render :file => "/public/404.html",:status  => "404" 
    end 
  end

  # GET /employees/1/edit
  def edit
    if current_category.category=="HR" or @employee.id == current_user.id
      @flag="edit"
      @employee = Employee.find(params[:id])
      @phones = EmployeePhone.where("employee_id = ? ", @employee.id ).select([:phone])
      @flag_new=0
      @cat=Category.find_by(:id => @employee.category_id)
      @category_id=@cat.id
    else
      render :file => "/public/404.html",:status  => "404" 
    end 
  end

  # POST /employees
  def create
    if current_category.category=="HR"
      @employee = Employee.new(employee_params)
      if  @employee.salary != nil
        @employee.houre_rate=@employee.salary/(26*8) #calculate hour_rate of employee
      end
      if @employee.password != ""
        @employee.password=Digest::MD5.hexdigest(@employee.password) #convert password to md5 for security
        @employee.password_confirmation=Digest::MD5.hexdigest(@employee.password_confirmation)
      end
      respond_to do |format|
        if @employee.save
          last_id = Employee.maximum('id')
          Employee.where("id = ? ", last_id).update_all(:status => "yes" )
          if defined? params[:employee_phones][:phone] 
              arr= params[:employee_phones][:phone].split(",")
              arr.each do |c|
                if c != nil
                  @employeephone = EmployeePhone.new(phone: c, employee_id: @employee.id) 
                  @employeephone.save  
                end
              end
          else
              @employeephone = EmployeePhone.new(phone: ' ', employee_id: @employee.id) 
              @employeephone.save            
          end 

          format.html { redirect_to @employee }
          format.json { render :show, status: :created, location: @employee }
        else
          @flag_new=1
          params[:employee_phones][:phone]==" "
          format.html { render :new }
          format.json { render json: @employee.errors, status: :unprocessable_entity }
        end
      end
    else
      render :file => "/public/404.html",:status  => "404" 
    end   
  end

  # PATCH/PUT /employees/1
  def update
    if current_category.category=="HR" or @employee.id == current_user.id
      no_password_update = 0
      houre_rate = @employee.salary/(26*8) 
      employee_params[:houre_rate] = houre_rate
      respond_to do |format|
        old_password = @employee.password;
        if  employee_params[:password] == ""
          no_password_update = 1
        end
        if @employee.update(employee_params)
          if params[:employee_phones][:phone]==" "
            @employeephone = EmployeePhone.new(phone: ' ', employee_id: @employee.id) 
            @employeephone.save  
          else
            arr= params[:employee_phones][:phone].split(",")
            arr.each do |c|
              puts c  
              if c != ""
               @employeephone = EmployeePhone.new(phone: c, employee_id: @employee.id) 
               @employeephone.save 
              end
            end 
            if no_password_update == 1
              Employee.where("id = ? ", @employee.id).update_all(:password =>  old_password )  
            else
              if employee_params[:password]
              new_password =Digest::MD5.hexdigest(employee_params[:password]) #convert password to md5 for security
              puts new_password
              Employee.where("id = ? ", @employee.id).update_all(:password =>  new_password )
            end
            end
          end   
          format.html { redirect_to @employee }
          format.json { render :show, status: :ok, location: @employee }
        else
          @cat=Category.find_by(:id => @employee.category_id)
          @category_id=@cat.id
          @flag_new=0
          format.html { render :edit }
          format.json { render json: @employee.errors, status: :unprocessable_entity }
        end
      end
    else
      render :file => "/public/404.html",:status  => "404" 
    end   
  end

  # DELETE /employees/1
  def destroy
    if false
      @employee.destroy
      respond_to do |format|
        format.html { redirect_to employees_url }
        format.json { head :no_content }
      end
    else
      render :file => "/public/404.html",:status  => "404" 
    end   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit( :email, :salary, :education_level , :education, :Governamental_ID,  :category_id, :crew_id, :image, :password , :full_name, :password_confirmation ,:status)
    end

    def phone_params
      params.require(:employee).permit(:phone)
    end

end
