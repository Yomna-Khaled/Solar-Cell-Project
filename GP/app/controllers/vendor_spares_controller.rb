class VendorSparesController < ApplicationController
  before_action :set_vendor_spare, only: [:show, :edit, :update, :destroy]

  # GET /vendor_spares
  # GET /vendor_spares.json
  def index
    @vendor_spares = VendorSpare.all
  end

  # GET /vendor_spares/1
  # GET /vendor_spares/1.json
  def show
  end

  # GET /vendor_spares/new
  def new
    @vendor_spare = VendorSpare.new
  end

  # GET /vendor_spares/1/edit
  def edit
  end

  # POST /vendor_spares
  # POST /vendor_spares.json
  def create
    @vendor_spare = VendorSpare.new(vendor_spare_params)

    respond_to do |format|
      if @vendor_spare.save
        format.html { redirect_to @vendor_spare, notice: 'Vendor spare was successfully created.' }
        format.json { render :show, status: :created, location: @vendor_spare }
      else
        format.html { render :new }
        format.json { render json: @vendor_spare.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vendor_spares/1
  # PATCH/PUT /vendor_spares/1.json
  def update
    respond_to do |format|
      if @vendor_spare.update(vendor_spare_params)
        format.html { redirect_to @vendor_spare, notice: 'Vendor spare was successfully updated.' }
        format.json { render :show, status: :ok, location: @vendor_spare }
      else
        format.html { render :edit }
        format.json { render json: @vendor_spare.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendor_spares/1
  # DELETE /vendor_spares/1.json
  def destroy
    @vendor_spare.destroy
    respond_to do |format|
      format.html { redirect_to vendor_spares_url, notice: 'Vendor spare was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor_spare
      @vendor_spare = VendorSpare.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vendor_spare_params
      params.require(:vendor_spare).permit(:date, :vendor_id, :spare_part_id)
    end
end
