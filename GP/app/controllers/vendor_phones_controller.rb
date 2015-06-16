class VendorPhonesController < ApplicationController
  before_action :set_vendor_phone, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404,:layout => false
  end
  # GET /vendor_phones
  # GET /vendor_phones.json
  def index  
    if  false 
      @vendor_phones = VendorPhone.all
    else
      render :file => "/public/404.html",:status  => "404" 
    end  
  end

def pho
@vendorphones_selected = params[:phone]
end

  # GET /vendor_phones/1
  # GET /vendor_phones/1.json
  def show
    if  false
      else
      render :file => "/public/404.html",:status  => "404" 
    end
  end

  # GET /vendor_phones/new
  def new
    if  false
      @vendor_phone = VendorPhone.new
    else
      render :file => "/public/404.html",:status  => "404" 
    end  
  end

  # GET /vendor_phones/1/edit
  def edit
    if  false
      else
      render :file => "/public/404.html",:status  => "404" 
    end
  end

  # POST /vendor_phones
  # POST /vendor_phones.json
  def create
    @vendor_phone = VendorPhone.new(vendor_phone_params)
    respond_to do |format|
      if @vendor_phone.save
        format.html { redirect_to @vendor_phone }
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
        format.html { redirect_to @vendor_phone }
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
    if  false
     @content = VendorPhone.find(params[:phone])
      @content.destroy

        @vendor_phone.destroy
        respond_to do |format|
          format.html { redirect_to vendor_phones_url }
          format.json { head :no_content }
        end
    else
      render :file => "/public/404.html",:status  => "404" 
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
