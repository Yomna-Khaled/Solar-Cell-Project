class VendorPhonesController < ApplicationController
  before_action :set_vendor_phone, only: [:show, :edit, :update, :destroy]

  # GET /vendor_phones
  # GET /vendor_phones.json
  def index
    @vendor_phones = VendorPhone.all
  end

  # GET /vendor_phones/1
  # GET /vendor_phones/1.json
  def show
  end

  # GET /vendor_phones/new
  def new
    @vendor_phone = VendorPhone.new
  end

  # GET /vendor_phones/1/edit
  def edit
  end

  # POST /vendor_phones
  # POST /vendor_phones.json
  def create
    @vendor_phone = VendorPhone.new(vendor_phone_params)

    respond_to do |format|
      if @vendor_phone.save
        format.html { redirect_to @vendor_phone, notice: 'Vendor phone was successfully created.' }
        format.json { render :show, status: :created, location: @vendor_phone }
      else
        format.html { render :new }
        format.json { render json: @vendor_phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vendor_phones/1
  # PATCH/PUT /vendor_phones/1.json
  def update
    respond_to do |format|
      if @vendor_phone.update(vendor_phone_params)
        format.html { redirect_to @vendor_phone, notice: 'Vendor phone was successfully updated.' }
        format.json { render :show, status: :ok, location: @vendor_phone }
      else
        format.html { render :edit }
        format.json { render json: @vendor_phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendor_phones/1
  # DELETE /vendor_phones/1.json
  def destroy
    @vendor_phone.destroy
    respond_to do |format|
      format.html { redirect_to vendor_phones_url, notice: 'Vendor phone was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor_phone
      @vendor_phone = VendorPhone.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vendor_phone_params
      params.require(:vendor_phone).permit(:vendor_id, :phone)
    end
end