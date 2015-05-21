class EmployeeManagersController < ApplicationController
  before_action :set_employee_manager, only: [:show, :edit, :update, :destroy]

  # GET /employee_managers
  # GET /employee_managers.json
  def index
    @employee_managers = EmployeeManager.all
  end

  # GET /employee_managers/1
  # GET /employee_managers/1.json
  def show
  end

  # GET /employee_managers/new
  def new
    @employee_manager = EmployeeManager.new
  end

  # GET /employee_managers/1/edit
  def edit
  end

  # POST /employee_managers
  # POST /employee_managers.json
  def create
    @employee_manager = EmployeeManager.new(employee_manager_params)

    respond_to do |format|
      if @employee_manager.save
        format.html { redirect_to @employee_manager, notice: 'Employee manager was successfully created.' }
        format.json { render :show, status: :created, location: @employee_manager }
      else
        format.html { render :new }
        format.json { render json: @employee_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employee_managers/1
  # PATCH/PUT /employee_managers/1.json
  def update
    respond_to do |format|
      if @employee_manager.update(employee_manager_params)
        format.html { redirect_to @employee_manager, notice: 'Employee manager was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee_manager }
      else
        format.html { render :edit }
        format.json { render json: @employee_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employee_managers/1
  # DELETE /employee_managers/1.json
  def destroy
    @employee_manager.destroy
    respond_to do |format|
      format.html { redirect_to employee_managers_url, notice: 'Employee manager was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_manager
      @employee_manager = EmployeeManager.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_manager_params
      params.require(:employee_manager).permit(:employee_id, :crew_id, :start_date, :end_date)
    end
end
