class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404
  end
  # GET /properties
  # GET /properties.json
  def index
    if false
      @properties = Property.all
    else
      render :file => "/public/404.html",:status  => "404"  
    end   
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    if false
    else
      render :file => "/public/404.html",:status  => "404"  
    end 
  end

  # GET /properties/new
  def new
    if false
      @property = Property.new
    else
      render :file => "/public/404.html",:status  => "404"  
    end  
  end

  # GET /properties/1/edit
  def edit
    if false
    else
      render :file => "/public/404.html",:status  => "404"  
    end  
  end

  # POST /properties
  # POST /properties.json
  def create
    @propertyname=params[:propertyname]
    @property = Property.new(name: @propertyname)
    @property.save
    render json: @property
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    if false
      @property.destroy
      respond_to do |format|
        format.html { redirect_to properties_url }
        format.json { head :no_content }
      end
    else
      render :file => "/public/404.html",:status  => "404"  
    end   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.require(:property).permit(:name)
    end
end
