class VendorsController < ApplicationController
  before_action :set_vendor, only: [:show, :edit, :update, :destroy]

  # GET /vendors
  # GET /vendors.json
  def index

    if logged_in? and current_category.category=="Sales"
         @vendors = Vendor.all
    else
      redirect_to login_path  
    end     

  end

def pho
@vendorphones_selected = VendorPhone.where("phone = ?",params[:phone])
@vendorphones_selected[0].destroy
end

  # GET /vendors/1
  # GET /vendors/1.json
  def show
    @vendor_phones = VendorPhone.where("vendor_id=?",@vendor.id)
  end

  # GET /vendors/new
  def new
    if logged_in? and current_category.category=="Sales"
      @vendor = Vendor.new
      @flag="new"
    else
      redirect_to login_path  
    end
  end

  # GET /vendors/1/edit
  def edit
	@flag="edit"
        @vendor = Vendor.find(params[:id])
        @phones = VendorPhone.where("vendor_id = ? ", @vendor.id ).select([:phone])
  end

  # POST /vendors
  # POST /vendors.json
  def create
	@vendor = Vendor.new(vendor_params)
      respond_to do |format|
        if @vendor.save
  
          if defined? params[:vendor_phones][:phone] 
            arr= params[:vendor_phones][:phone].split(",")
            arr.each do |c|
              if c != nil

                @vendorphone = VendorPhone.new(phone: c, vendor_id: @vendor.id) 
                @vendorphone.save  
              end
 
            end

          else
            
            @vendorphone = VendorPhone.new(phone: ' ', vendor_id: @vendor.id) 
            @vendorphone.save            
	        end    
          format.html { redirect_to @vendor }
          format.json { render :show, status: :created, location: @vendor }
        else
          # if params[:vendor_phones][:phone]==" "
          #   @vendorphone = VendorPhone.new(phone: ' ', vendor_id: @vendor.id) 
          #   @vendorphone.save  
	         # end 
	           params[:vendor_phones][:phone]==" "
            format.html { render :new }
            format.json { render json: @vendor.errors, status: :unprocessable_entity }
              
        end
  end
end

  def materialvendorcreate
    @vendorname=params[:vendorname]
    @vendoremail = params[:vendoremail]
    @vendor = Vendor.new(name: @vendorname, email: @vendoremail)
    @vendor.save
    render json: @vendor
  end 


  

  # PATCH/PUT /vendors/1
  # PATCH/PUT /vendors/1.json
  def update
    respond_to do |format|
      if @vendor.update(vendor_params)

      arr= params[:vendor_phones][:phone].split(",")
	 arr.each do |c|
		puts c	
        if c != ""
           @vendorphone = VendorPhone.new(phone: c, vendor_id: @vendor.id) 
           @vendorphone.save 
        end

	 end    


        format.html { redirect_to @vendor }
        format.json { render :show, status: :ok, location: @vendor }
      else
        format.html { render :edit }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendors/1
  # DELETE /vendors/1.json
  def destroy
   
    
    @vendor.destroy
    respond_to do |format|
      format.html { redirect_to vendors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor
      @vendor = Vendor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vendor_params
      params.require(:vendor).permit(:name, :email )
    end

	 def phone_params
      params.require(:vendor).permit(:phone)
    end
end
