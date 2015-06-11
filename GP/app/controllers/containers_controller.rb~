class ContainersController < ApplicationController
   skip_before_action :verify_authenticity_token
  before_action :set_container, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, only: [:show, :edit, :update, :destroy,:index,:new,:create]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  # Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404
  end
  # GET /containers
  # GET /containers.json
  def index
    if logged_in? and current_category.category=="Sales"
     @containers = Container.all
     @containers = Container.paginate(:page => params[:page], :per_page => 6)

    else
      render :file => "/public/404.html",:status  => "404"   
    end   
  end

  # GET /containers/1
  # GET /containers/1.json
  def show
    if logged_in? and current_category.category=="Sales"
     else
      render :file => "/public/404.html",:status  => "404"   
    end  
  end

  # GET /containers/new
  def new
    if logged_in? and current_category.category=="Sales"
       @container = Container.new
       @vendors = Vendor.all
       @flag="new"
    else
      render :file => "/public/404.html",:status  => "404"   
    end 
  end

  # GET /containers/1/edit
  def edit
   if logged_in? and current_category.category=="Sales" 
    @vendors = Vendor.all
    @containervendor = VendorContainer.where("container_id=?",@container.id)
    @containervendor_sorted = @containervendor.order(updated_at: :desc)
    @vendor_id =  @containervendor_sorted[0].vendor_id
    @flag="edit"
    else
      render :file => "/public/404.html",:status  => "404"   
    end 

  end

  # POST /containers
  # POST /containers.json
  def create
    @container = Container.new(container_params)
    @vendor_id = params['vendor'];


    respond_to do |format|
      if @container.save       
        @vendorcontainer = VendorContainer.new(vendor_id: @vendor_id, container_id: @container.id )        
        @container_id=Container.maximum('id')
        @vendor_id = params['vendor_id'];
        @vendorcontainer.save
        format.html { redirect_to @container}
        format.json { render :show, status: :created, location: @container }
      else
        @vendors = Vendor.all
        format.html { render :new }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /containers/1
  # PATCH/PUT /containers/1.json
  def update
    @vendoredit_id = params['vendor']; #to get vendor of certain material
    @vendororiginal_id = VendorContainer.where("container_id=?",@container.id)[0].vendor_id
    respond_to do |format|
      if @container.update(container_params)
        if @vendoredit_id != @vendororiginal_id
            @vendorcontainer = VendorContainer.new(vendor_id: @vendoredit_id, container_id: @container.id )  
            @vendorcontainer.save
        end
        format.html { redirect_to @container, notice: 'Container was successfully updated.' }
        format.json { render :show, status: :ok, location: @container }
      else
        @vendors = Vendor.all
        format.html { render :edit }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /containers/1
  # DELETE /containers/1.json
  def destroy
    if false
      @container.destroy
      respond_to do |format|
        format.html { redirect_to containers_url }
        format.json { head :no_content }
      end
    else
      render :file => "/public/404.html",:status  => "404"   
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
