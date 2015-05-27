class ContainersController < ApplicationController
  before_action :set_container, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, only: [:show, :edit, :update, :destroy,:index,:new,:create]

  # GET /containers
  # GET /containers.json
  def index
    if logged_in? and current_category.category=="Sales"
     @containers = Container.all
    else
      redirect_to login_path  
    end   
  end

  # GET /containers/1
  # GET /containers/1.json
  def show
  end

  # GET /containers/new
  def new
    if logged_in? and current_category.category=="Sales"
       @container = Container.new
       @vendors = Vendor.all
    else
      redirect_to login_path  
    end 
  end

  # GET /containers/1/edit
  def edit
    @vendors = Vendor.all
  end

  # POST /containers
  # POST /containers.json
  def create
    @container = Container.new(container_params)
    


    respond_to do |format|
      if @container.save       
        @vendorcontainer = VendorContainer.new(vendor_id: @vendor_id, container_id: @container.id )        
        @container_id=Container.maximum('id')
        @vendor_id = params['vendor_id'];
        @vendorcontainer.save
        format.html { redirect_to @container}
        format.json { render :show, status: :created, location: @container }

      else
        format.html { render :new }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /containers/1
  # PATCH/PUT /containers/1.json
  def update
    respond_to do |format|
      if @container.update(container_params)
        format.html { redirect_to @container }
        format.json { render :show, status: :ok, location: @container }
      else
        format.html { render :edit }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /containers/1
  # DELETE /containers/1.json
  def destroy
    @container.destroy
    respond_to do |format|
      format.html { redirect_to containers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_container
      @container = Container.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def container_params
      params.require(:container).permit(:width, :height, :serialNo, :capacity, :price, :total_power)
    end
    
    def authenticate
        if !logged_in?
          redirect_to login_path
        end 
    end
 
end
