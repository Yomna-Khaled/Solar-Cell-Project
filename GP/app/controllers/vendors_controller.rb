class VendorsController < ApplicationController
  before_action :set_vendor, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404
  end
  # GET /vendors
  # GET /vendors.json
  def index
    if  current_category.category=="Buyer" or current_category.category=="Admin"
     @vendors = Vendor.all
     @vendors = Vendor.paginate(:page => params[:page], :per_page => 6)
    else
      render :file => "/public/404.html",:status  => "404"  
    end     

  end
  def black

      @vendor=Vendor.where("id= ?",params[:id])

      puts @vendor[0].blacklisted
      if @vendor[0].blacklisted=="yes"

      @vendor.update_all(:blacklisted => "no" )
    else
      puts "here"
      @vendor.update_all(:blacklisted => "yes" )
    end
      render plain: "ok"
  end  

def pho
  @vendorphones_selected = VendorPhone.where("phone = ?",params[:phone])
  @vendorphones_selected[0].destroy
end

  # GET /vendors/1
  # GET /vendors/1.json
  def show
    if current_category.category=="Buyer" or current_category.category=="Admin"
      @vendor_phones = VendorPhone.where("vendor_id=?",@vendor.id)
    else
      render :file => "/public/404.html",:status  => "404" 
    end  
  end

  # GET /vendors/new
  def new
    if logged_in? and current_category.category=="Buyer"
      @vendor = Vendor.new
      @flag="new"
    else
      render :file => "/public/404.html",:status  => "404"  
    end
  end

  # GET /vendors/1/edit
  def edit
    if logged_in? and current_category.category=="Buyer"
	      @flag="edit"
        @vendor = Vendor.find(params[:id])
        @phones = VendorPhone.where("vendor_id = ? ", @vendor.id ).select([:phone])
    else
      render :file => "/public/404.html",:status  => "404"  
    end    
  end

  # POST /vendors
  # POST /vendors.json
  def create
	@vendor = Vendor.new(vendor_params)
      respond_to do |format|
        if @vendor.save
          last_id = Vendor.maximum('id')
          Vendor.where("id = ? ", last_id).update_all(:blacklisted => "no" )
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
         
      if params[:vendor_phones][:phone]==" "
         @vendorphone = VendorPhone.new(phone: ' ', vendor_id: @vendor.id) 
         @vendorphone.save  
        else

         arr= params[:vendor_phones][:phone].split(",")
	 arr.each do |c|
		puts c	
        if c != ""
           @vendorphone = VendorPhone.new(phone: c, vendor_id: @vendor.id) 
           @vendorphone.save 
        end


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
   
    if false
      @vendor.destroy
      respond_to do |format|
        format.html { redirect_to vendors_url }
        format.json { head :no_content }
      end
    else
      render :file => "/public/404.html",:status  => "404" 
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor
      @vendor = Vendor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vendor_params
      params.require(:vendor).permit(:name, :email, :ventype , :address, :city)
    end

	 def phone_params
      params.require(:vendor).permit(:phone)
    end
end
