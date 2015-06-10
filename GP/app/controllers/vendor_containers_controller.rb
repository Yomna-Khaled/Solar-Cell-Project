class VendorContainersController < ApplicationController
  before_action :set_vendor_container, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404
  end
  # GET /vendor_containers
  # GET /vendor_containers.json
  def index
    if false
      @vendor_containers = VendorContainer.all
    else
      render :file => "/public/404.html",:status  => "404" 
    end 
  end

  # GET /vendor_containers/1
  # GET /vendor_containers/1.json
  def show
    if false
      else
      render :file => "/public/404.html",:status  => "404" 
    end 
  end

  # GET /vendor_containers/new
  def new
    if false
    @vendor_container = VendorContainer.new
    else
      render :file => "/public/404.html",:status  => "404" 
    end 
  end

  # GET /vendor_containers/1/edit
  def edit
    if false
      else
      render :file => "/public/404.html",:status  => "404" 
    end 
  end

  # POST /vendor_containers
  # POST /vendor_containers.json
  def create
    @vendor_container = VendorContainer.new(vendor_container_params)

    respond_to do |format|
      if @vendor_container.save
        format.html { redirect_to @vendor_container }
        format.json { render :show, status: :created, location: @vendor_container }
      else
        format.html { render :new }
        format.json { render json: @vendor_container.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vendor_containers/1
  # PATCH/PUT /vendor_containers/1.json
  def update
    respond_to do |format|
      if @vendor_container.update(vendor_container_params)
        format.html { redirect_to @vendor_container }
        format.json { render :show, status: :ok, location: @vendor_container }
      else
        format.html { render :edit }
        format.json { render json: @vendor_container.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendor_containers/1
  # DELETE /vendor_containers/1.json
  def destroy
    if false
    @vendor_container.destroy
    respond_to do |format|
      format.html { redirect_to vendor_containers_url }
      format.json { head :no_content }
    end
    else
      render :file => "/public/404.html",:status  => "404" 
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor_container
      @vendor_container = VendorContainer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vendor_container_params
      params.require(:vendor_container).permit(:vendor_id, :container_id, :date)
    end
end
