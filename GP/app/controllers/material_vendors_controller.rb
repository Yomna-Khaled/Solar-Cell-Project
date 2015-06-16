class MaterialVendorsController < ApplicationController
   skip_before_action :verify_authenticity_token
  before_action :set_material_vendor, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404,:layout => false
  end
  # GET /material_vendors
  # GET /material_vendors.json
  def index
    if false
      @material_vendors = MaterialVendor.all
    else
      render :file => "/public/404.html",:status  => "404" 
    end
  end

  # GET /material_vendors/1
  # GET /material_vendors/1.json
  def show
    if false
    else
      render :file => "/public/404.html",:status  => "404" 
    end
  end

  # GET /material_vendors/new
  def new
    if false
      @material_vendor = MaterialVendor.new
    else
      render :file => "/public/404.html",:status  => "404" 
    end  
  end

  # GET /material_vendors/1/edit
  def edit
    if false
    else
      render :file => "/public/404.html",:status  => "404" 
    end
  end

  # POST /material_vendors
  # POST /material_vendors.json
  def create
    @material_vendor = MaterialVendor.new(material_vendor_params)

    respond_to do |format|
      if @material_vendor.save
        format.html { redirect_to @material_vendor }
        format.json { render :show, status: :created, location: @material_vendor }
      else
        format.html { render :new }
        format.json { render json: @material_vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /material_vendors/1
  # PATCH/PUT /material_vendors/1.json
  def update
    respond_to do |format|
      if @material_vendor.update(material_vendor_params)
        format.html { redirect_to @material_vendor }
        format.json { render :show, status: :ok, location: @material_vendor }
      else
        format.html { render :edit }
        format.json { render json: @material_vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /material_vendors/1
  # DELETE /material_vendors/1.json
  def destroy
    if false
      @material_vendor.destroy
      respond_to do |format|
        format.html { redirect_to material_vendors_url }
        format.json { head :no_content }
      end
    else
      render :file => "/public/404.html",:status  => "404" 
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material_vendor
      @material_vendor = MaterialVendor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def material_vendor_params
      params.require(:material_vendor).permit(:vendor_id, :material_id, :date)
    end
end
