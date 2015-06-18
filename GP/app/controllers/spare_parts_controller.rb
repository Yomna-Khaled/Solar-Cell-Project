class SparePartsController < ApplicationController
  before_action :set_spare_part, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  skip_before_action :verify_authenticity_token
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404,:layout => false
  end
  # GET /spare_parts
  # GET /spare_parts.json
  def index
    if current_category.category=="Buyer" or current_category.category=="Stock Keeper" or current_category.category=="Admin"
        @spare_parts = SparePart.all
        @spare_parts = SparePart.paginate(:page => params[:page], :per_page => 6)
    else
      render :file => "/public/404.html",:status  => "404"  
    end    
  end

  # GET /spare_parts/1
  # GET /spare_parts/1.json
  def show
    if current_category.category=="Buyer" or current_category.category=="Stock Keeper" or current_category.category=="Admin"
     else
      render :file => "/public/404.html",:status  => "404"  
    end
  end

  # GET /spare_parts/new
  def new
    if  current_category.category=="Buyer"      
        @spare_part = SparePart.new
        @vendors = Vendor.where("blacklisted = ? " , "no")
        @machines = Machine.all
        @flag="new"
    else
      render :file => "/public/404.html",:status  => "404"  
    end 

  end

  # GET /spare_parts/1/edit
  def edit
    if logged_in? and (current_category.category=="Buyer" )
      @vendors = Vendor.where("blacklisted = ? " , "no")
      @machines = Machine.all 
      @sparevendor = VendorSpare.where("spare_part_id=? AND date IS NULL",@spare_part.id)
      @sparevendor_sorted = @sparevendor.order(updated_at: :desc)
      @vendor_id =  @sparevendor_sorted[0].vendor_id
      @flag="edit"
    else
      render :file => "/public/404.html",:status  => "404"  
    end  
  end

  # POST /spare_parts
  # POST /spare_parts.json
  def create
    @spare_part = SparePart.new(spare_part_params)
    @vendor_id = params['vendor'];
    respond_to do |format|
      if @spare_part.save
         @vendorspare = VendorSpare.new(vendor_id: @vendor_id, spare_part_id: @spare_part.id )
         @vendorspare.save
        format.html { redirect_to @spare_part }
        format.json { render :show, status: :created, location: @spare_part }
 
      else
	    @vendors = Vendor.where("blacklisted = ? " , "no")
      @machines = Machine.all 
      @flag="new"
        format.html { render :new }
        format.json { render json: @spare_part.errors, status: :unprocessable_entity }
      end
    end
  end





  # PATCH/PUT /spare_parts/1
  # PATCH/PUT /spare_parts/1.json
  def update
    @vendoredit_id = params['vendor']; #to get vendor of certain material
    @current_vendor_record = VendorSpare.where("spare_part_id=? AND date IS NULL ",@spare_part.id)
    @vendororiginal_id = @current_vendor_record[0].vendor_id
    respond_to do |format|
      if @spare_part.update(spare_part_params)
        if @vendoredit_id != @vendororiginal_id
        @record_id = @current_vendor_record[0].id
        # update last record to set end date for last vendor
        @last_sparepart_vendor = VendorSpare.find_by(id: @record_id)
        @last_sparepart_vendor.update(date: Date.today)
        # create new record with the new vendor for this material
        @vendorspare = VendorSpare.new(spare_part_id: @spare_part.id, vendor_id: @vendoredit_id) 
        @vendorspare.save 
        end
        format.html { redirect_to @spare_part, notice: 'Spare part was successfully updated.' }
        format.json { render :show, status: :ok, location: @spare_part }
      else
        @vendors = Vendor.where("blacklisted = ? " , "no")
        @machines = Machine.all 
        format.html { render :edit }
        format.json { render json: @spare_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spare_parts/1
  # DELETE /spare_parts/1.json
  def destroy
    if false
       @spare_part.destroy
         respond_to do |format|
         format.html { redirect_to spare_parts_url }
         format.json { head :no_content }
       end
    else
      render :file => "/public/404.html",:status  => "404"  
    end   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spare_part
      @spare_part = SparePart.find(params[:id])
      @vendor_id = params['vendor'];
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spare_part_params
      params.require(:spare_part).permit(:name, :quantity, :price, :machine_id, :avatar)
    end
    
end
