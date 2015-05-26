class MaterialsController < ApplicationController
  before_action :set_material, only: [:show, :edit, :update, :destroy]

  # GET /materials
  # GET /materials.json
  def index    
    if logged_in? and (current_category.category=="Sales" or current_category.category=="Stock Keeper")
      @materials = Material.all
      @material_vendor = MaterialVendor.all
    else
      redirect_to login_path  
    end   
  end

  # GET /materials/1
  # GET /materials/1.json
  def show
  end

  # GET /materials/new
  def new

    if logged_in? and current_category.category=="Sales"
      @material = Material.new
      @vendors = Vendor.all
      @quantites = Quantity.all
      @properties = Property.all
      @flag = "new"
    else
      redirect_to login_path  
    end   
  end

  # GET /materials/1/edit
  def edit
    @vendors = Vendor.all
    @quantites = Quantity.all
    @properties = Property.all
    @material_property = MaterialProperty.all
    # to select the latest vendor for material 
    @materialvendor = MaterialVendor.where("material_id=?",@material.id)
    @materialvendor_sorted = @materialvendor.order(updated_at: :desc)
    @vendor_id =  @materialvendor_sorted[0].vendor_id
    # to select all properties for material
    @materialproperties_selected_ids = Array.new 
    @materialproperties_selected = MaterialProperty.where("material_id=?",@material.id)
    @materialproperties_selected.each do |materialproperty_selected|
      id = materialproperty_selected.property_id
      @materialproperties_selected_ids.push(id)
    end
    @flag = "edit"
      if logged_in? and current_category.category=="Stock Keeper"
        @flag_stock=0
      end
  end

  # POST /materials
  # POST /materials.json
  def create
    @vendor_id = params['vendor']; #to get vendor of certain material 
    @selected_properties = params['propertycheck']; #it is an array of selected properties
    # render plain: material_params
    @material = Material.new(material_params)

    respond_to do |format|
      if @material.save
        material_id = @material.id
        @selected_properties.each do |selected_property|
          propertyid = selected_property.split(":")[0]
          propertyvalue = selected_property.split(":")[1]
          @materialproperty = MaterialProperty.new(material_id: material_id, property_id: propertyid, value: propertyvalue )
          @materialproperty.save
        end
        @materialvendor = MaterialVendor.new(material_id: material_id, vendor_id: @vendor_id, date: Date.today )
        @materialvendor.save
        format.html { redirect_to @material, notice: 'Material was successfully created.' }
        format.json { render :show, status: :created, location: @material }
      else
        @vendors = Vendor.all
        @quantites = Quantity.all
        @properties = Property.all
        @flag = "new"
        format.html { render :new }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /materials/1
  # PATCH/PUT /materials/1.json

def update
  @vendoredit_id = params['vendor']; #to get vendor of certain material 
  @selected_properties = params['propertycheck']; #it is an array of selected properties
  @vendororiginal_id = MaterialVendor.where("material_id=?",@material.id)[0].vendor_id
  # render plain: @selected_properties
  respond_to do |format|
    if @material.update(material_params)
      if @vendoredit_id != @vendororiginal_id
        @materialvendor = MaterialVendor.new(material_id: @material.id, vendor_id: @vendoredit_id, date: Date.today )
        @materialvendor.save  
      end
      @material_properties_last = MaterialProperty.where("material_id = ? ", @material.id)
      @material_properties_last.each do |materialproperty_last|
        materialproperty_last.destroy
      end
      if @selected_properties
        @selected_properties.each do |selected_property|
          propertyid = selected_property.split(":")[0]
          propertyvalue = selected_property.split(":")[1]
          @materialproperty = MaterialProperty.new(material_id: @material.id, property_id: propertyid, value: propertyvalue )
          @materialproperty.save
        end  
      end

      format.html { redirect_to @material, notice: 'Material was successfully updated.' }
      format.json { render :show, status: :ok, location: @material }
    else
      format.html { render :edit }
      format.json { render json: @material.errors, status: :unprocessable_entity }
      @vendors = Vendor.all
      @quantites = Quantity.all
      @properties = Property.all
      @flag = "new"
    end
  end

end

  # DELETE /materials/1
  # DELETE /materials/1.json
  def destroy
    @material.destroy
    respond_to do |format|
      format.html { redirect_to materials_url  }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      @material = Material.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def material_params
      params.require(:material).permit(:name, :serial_number, :quantity_value, :price, :Min_Number, :stockNo, :shelfNo, :production_date, :expiration_date, :quantity_id, :avatar)
    end
end
