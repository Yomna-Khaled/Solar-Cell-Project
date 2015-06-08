class EmployeePhonesController < ApplicationController
  before_action :set_employee_phone, only: [:show, :edit, :update, :destroy]

  # GET /employee_phones
  # GET /employee_phones.json
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404
  end
    
  def index
    if false
      @employee_phones = EmployeePhone.all
    else
      render :file => "/public/404.html",:status  => "404"  
    end   
  end

  def pho
    @employeephones_selected = params[:phone]
  end

  # GET /employee_phones/1
  # GET /employee_phones/1.json
  def show
    if false
      else
      render :file => "/public/404.html",:status  => "404"  
    end 
  end

  # GET /employee_phones/new
  def new
    if false
      @employee_phone = EmployeePhone.new
      else
      render :file => "/public/404.html",:status  => "404"  
    end 
  end

  # GET /employee_phones/1/edit
  def edit
    if false
      else
      render :file => "/public/404.html",:status  => "404"  
    end
  end

  # POST /employee_phones
  # POST /employee_phones.json
  def create
    @employee_phone = EmployeePhone.new(employee_phone_params)
    respond_to do |format|
      if @employee_phone.save
        format.html { redirect_to @employee_phone  }
        format.json { render :show, status: :created, location: @employee_phone }
      else
        format.html { render :new }
        format.json { render json: @employee_phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employee_phones/1
  # PATCH/PUT /employee_phones/1.json
  def update
    respond_to do |format|
      if @employee_phone.update(employee_phone_params)
        format.html { redirect_to @employee_phone  }
        format.json { render :show, status: :ok, location: @employee_phone }
      else
        format.html { render :edit }
        format.json { render json: @employee_phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employee_phones/1
  # DELETE /employee_phones/1.json
  def destroy
    if false
      @employee_phone.destroy
      respond_to do |format|
        format.html { redirect_to employee_phones_url  }
        format.json { head :no_content }
      end
    else
      render :file => "/public/404.html",:status  => "404"  
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_phone
      @employee_phone = EmployeePhone.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_phone_params
      params.require(:employee_phone).permit(:employee_id, :phone)
    end
end
