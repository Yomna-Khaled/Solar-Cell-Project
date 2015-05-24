class MaterialsController < ApplicationController
  before_action :set_material, only: [:show, :edit, :update, :destroy]

  # GET /materials
  # GET /materials.json
  def index
    if logged_in? and current_category.category=="Sales"
      @materials = Material.all
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
      @flag_new=1 #display password field in from
      @material = Material.new
      @vendors = Vendor.all
      @quantites = Quantity.all
      @properties = Property.all
    else
      redirect_to login_path  
    end   

  end

  # GET /materials/1/edit
  def edit
      @flag_new=0
      @vendors = Vendor.all
      @quantites = Quantity.all
      @properties = Property.all
  end

  # POST /materials
  # POST /materials.json
  def create
    @vendor_id = params['vendor']; #to get vendor of certain material 
    @selected_properties = params['propertycheck']; #it is an array of selected properties
    # render plain: @selected_properties
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

        format.html { redirect_to @material, notice: 'Material was successfully created.' }
        format.json { render :show, status: :created, location: @material }
      else
        format.html { render :new }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /materials/1
  # PATCH/PUT /materials/1.json
  def update
    respond_to do |format|
      if @material.update(material_params)
        format.html { redirect_to @material, notice: 'Material was successfully updated.' }
        format.json { render :show, status: :ok, location: @material }
      else
        format.html { render :edit }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materials/1
  # DELETE /materials/1.json
  def destroy
    @material.destroy
    respond_to do |format|
      format.html { redirect_to materials_url, notice: 'Material was successfully destroyed.' }
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
      params.require(:material).permit(:name, :quantity_value, :price, :Min_Number, :stockNo, :shelfNo, :production_date, :expiration_date, :quantity_id, :avatar)
    end
end
