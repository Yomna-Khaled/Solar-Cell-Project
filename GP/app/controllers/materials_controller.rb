class MaterialsController < ApplicationController
   skip_before_action :verify_authenticity_token
  before_action :set_material, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  
  # Render 404 page when record not found
    def render_404      
       render :file => "/public/404.html", :status => 404
    end

    
  # GET /materials
  # GET /materials.json
  def index    
    if current_category.category=="Buyer" or current_category.category=="Stock Keeper" or current_category.category=="Admin"
      @materials = Material.all
      @materials = Material.paginate(:page => params[:page], :per_page => 10)
      @material_vendor = MaterialVendor.all
      @materials = Material.paginate(:page => params[:page], :per_page => 6)
    else
      render :file => "/public/404.html",:status  => "404" 
    end   
  end


  # GET /materials/1
  # GET /materials/1.json
  def show
    if current_category.category=="Buyer" or current_category.category=="Stock Keeper" or current_category.category=="Admin"
      @material_vendor = MaterialVendor.all
      @material_properties = MaterialProperty.where("material_id=?",@material.id)
      #report part for materials 
      respond_to do |format|
        format.html
        format.pdf do
          pdf = MaterialPdf.new(@material , @material_vendor , @material_properties )
          send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
        end
      end


    else
      render :file => "/public/404.html",:status  => "404" 
    end  
  end

  # GET /materials/new
  def new
    if  current_category.category=="Buyer"
      @material = Material.new
      @vendors = Vendor.where("blacklisted = ? " , "no")
      @quantites = Quantity.all
      @properties = Property.all
      @flag = "new"
    else
      render :file => "/public/404.html",:status  => "404"  
    end   
  end

  # GET /materials/1/edit
  def edit
   if logged_in? and (current_category.category=="Buyer" or current_category.category=="Stock Keeper") 
      @vendors = Vendor.all
      @quantites = Quantity.all
      @properties = Property.all
      @material_property = MaterialProperty.all
      # to select the latest vendor for material 
      @materialvendor = MaterialVendor.where("material_id=? AND date IS NULL",@material.id)
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
    else
      render :file => "/public/404.html",:status  => "404"  
    end 


      if logged_in? and current_category.category=="Stock Keeper"
        @flag_stock=0
      end
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
        if @selected_properties != nil
          @selected_properties.each do |selected_property|
            propertyid = selected_property.split(":")[0]
            propertyvalue = selected_property.split(":")[1]
            if propertyvalue
              @materialproperty = MaterialProperty.new(material_id: material_id, property_id: propertyid, value: propertyvalue )
              @materialproperty.save
            end
          end
        end
        @materialvendor = MaterialVendor.new(material_id: material_id, vendor_id: @vendor_id)
        @materialvendor.save
        format.html { redirect_to @material}
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
  @current_vendor_record = MaterialVendor.where("material_id=? AND date IS NULL ",@material.id)
  @vendororiginal_id = @current_vendor_record[0].vendor_id

  respond_to do |format|
    if @material.update(material_params)
      if @vendoredit_id != @vendororiginal_id
        @record_id = @current_vendor_record[0].id
        # update last record to set end date for last vendor
        @last_material_vendor = MaterialVendor.find_by(id: @record_id)
        @last_material_vendor.update(date: Date.today)
        # create new record with the new vendor for this material
        @materialvendor = MaterialVendor.new(material_id: @material.id, vendor_id: @vendoredit_id) 
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
          if propertyvalue 
            @materialproperty = MaterialProperty.new(material_id: @material.id, property_id: propertyid, value: propertyvalue )
            @materialproperty.save
          end

        end  
      end

      format.html { redirect_to @material }
      format.json { render :show, status: :ok, location: @material }
    else
      format.html { render :edit }
      format.json { render json: @material.errors, status: :unprocessable_entity }
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
    end
  end

end

  # DELETE /materials/1
  # DELETE /materials/1.json
  def destroy
    if false
      @material.destroy
      respond_to do |format|
        format.html { redirect_to materials_url  }
        format.json { head :no_content }
      end
    else
      render :file => "/public/404.html",:status  => "404"  
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
