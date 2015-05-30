class ProductionShiftsController < ApplicationController
  before_action :set_production_shift, only: [:show, :edit, :update, :destroy]

  # GET /production_shifts
  # GET /production_shifts.json
  def index
    #@production_shifts = ProductionShift.all
    @materials = Material.all
  end

  # GET /production_shifts/1
  # GET /production_shifts/1.json
  def show
  end

  # GET /production_shifts/new
  def new
   
    @production_shift = ProductionShift.new
    @materials = Material.all
   
  end

  # GET /production_shifts/1/edit
  def edit
  end

  # POST /production_shifts
  # POST /production_shifts.json
  def create

  #   @production_shift = ProductionShift.new(production_shift_params)
 # render plain:  params[params[:material_id][0]]
  
    @shift=Shift.maximum("id");
    params[:material_id].each_with_index do |item,i|
  @production_shift = ProductionShift.new(:material_id=> params[:material_id][i],:material_quantity=> params[params[:material_id][i]])
  @production_shift.save
end
   @materials = Material.all 
   render :new
end


  # PATCH/PUT /production_shifts/1
  # PATCH/PUT /production_shifts/1.json
  def update
    respond_to do |format|
      if @production_shift.update(production_shift_params)
        format.html { redirect_to @production_shift }
        format.json { render :show, status: :ok, location: @production_shift }
      else
        format.html { render :edit }
        format.json { render json: @production_shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /production_shifts/1
  # DELETE /production_shifts/1.json
  def destroy
    @production_shift.destroy
    respond_to do |format|
      format.html { redirect_to production_shifts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_production_shift
      @production_shift = ProductionShift.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def production_shift_params
      params.require(:production_shift).permit(:material_id, :shift_id, :material_quantity)
    end
end
