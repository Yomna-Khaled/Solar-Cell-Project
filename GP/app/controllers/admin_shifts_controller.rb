class AdminShiftsController < ApplicationController
  before_action :set_admin_shift, only: [:show, :edit, :update, :destroy]

  # GET /admin_shifts
  # GET /admin_shifts.json
  def index
    @admin_shifts = AdminShift.all
  end

  # GET /admin_shifts/1
  # GET /admin_shifts/1.json
  def show
  end

  # GET /admin_shifts/new
  def new
    @admin_shift = AdminShift.new
  end

  # GET /admin_shifts/1/edit
  def edit
  end

  # POST /admin_shifts
  # POST /admin_shifts.json
  def create
    @admin_shift = AdminShift.new(admin_shift_params)

    respond_to do |format|
      if @admin_shift.save
        format.html { redirect_to @admin_shift, notice: 'Admin shift was successfully created.' }
        format.json { render :show, status: :created, location: @admin_shift }
      else
        format.html { render :new }
        format.json { render json: @admin_shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_shifts/1
  # PATCH/PUT /admin_shifts/1.json
  def update
    respond_to do |format|
      if @admin_shift.update(admin_shift_params)
        format.html { redirect_to @admin_shift, notice: 'Admin shift was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_shift }
      else
        format.html { render :edit }
        format.json { render json: @admin_shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_shifts/1
  # DELETE /admin_shifts/1.json
  def destroy
    @admin_shift.destroy
    respond_to do |format|
      format.html { redirect_to admin_shifts_url, notice: 'Admin shift was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_shift
      @admin_shift = AdminShift.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_shift_params
      params.require(:admin_shift).permit(:power, :type, :subtype, :employee_id)
    end
end
