class MaterialPropertiesController < ApplicationController
  before_action :set_material_property, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404
  end
  # GET /material_properties
  # GET /material_properties.json
  def index
    @material_properties = MaterialProperty.all
  end

  # GET /material_properties/1
  # GET /material_properties/1.json
  def show
  end

  # GET /material_properties/new
  def new
    @material_property = MaterialProperty.new
  end

  # GET /material_properties/1/edit
  def edit
  end

  # POST /material_properties
  # POST /material_properties.json
  def create
    @material_property = MaterialProperty.new(material_property_params)

    respond_to do |format|
      if @material_property.save
        format.html { redirect_to @material_property }
        format.json { render :show, status: :created, location: @material_property }
      else
        format.html { render :new }
        format.json { render json: @material_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /material_properties/1
  # PATCH/PUT /material_properties/1.json
  def update
    respond_to do |format|
      if @material_property.update(material_property_params)
        format.html { redirect_to @material_property  }
        format.json { render :show, status: :ok, location: @material_property }
      else
        format.html { render :edit }
        format.json { render json: @material_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /material_properties/1
  # DELETE /material_properties/1.json
  def destroy
    @material_property.destroy
    respond_to do |format|
      format.html { redirect_to material_properties_url  }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material_property
      @material_property = MaterialProperty.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def material_property_params
      params.require(:material_property).permit(:material_id, :property_id)
    end
end
