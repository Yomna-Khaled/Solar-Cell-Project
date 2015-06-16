class VendorsController < ApplicationController
  before_action :set_vendor, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404,:layout => false
  end
  # GET /vendors
  # GET /vendors.json
  def index
    if  current_category.category=="Buyer" or current_category.category=="Admin" 
      if params[:vendortype] == 'sparepart'
        session[:vendortype] = 'sparepart'
      elsif params[:vendortype] == 'material'
          session[:vendortype] = 'material'
      elsif params[:vendortype] == 'pallet'
          session[:vendortype] = 'pallet'
      end

      if session[:vendortype] == 'sparepart'  
        @listcritetia = "sparepart"
        if params[:searchtype] == 'date'
          @vendors = VendorSpare.where("date like ? OR created_at like ?", "%#{params[:search]}%","%#{params[:search]}%").order("created_at DESC")
        elsif params[:searchtype] == 'name'
          @sparepart = SparePart.where("name like ?", "%#{params[:search]}%")[0]
          if @sparepart != nil
            @vendors = VendorSpare.where("spare_part_id = ?", @sparepart.id).order("created_at DESC")
          else
            @vendors = VendorSpare.where("spare_part_id = NULL").order("created_at DESC")
          end
        else
          @vendors = VendorSpare.all.order(created_at: :desc)
        end        
        
      elsif session[:vendortype] == 'pallet'  
        @listcritetia = "pallet"
        if params[:searchtype] == 'date'
          @vendors = VendorContainer.where("date like ? OR created_at like ?", "%#{params[:search]}%","%#{params[:search]}%").order("created_at DESC")
        elsif params[:searchtype] == 'name'
          @container = Container.where("serialNo like ?", "%#{params[:search]}%")[0]
          if @container != nil
            @vendors = VendorContainer.where("container_id = ?", @container.id).order("created_at DESC")
          else
            @vendors = VendorContainer.where("container_id = NULL").order("created_at DESC")
          end
        else
          @vendors = VendorContainer.all.order(created_at: :desc)
        end
      elsif session[:vendortype] == 'material' or session[:vendortype] == nil
        @listcritetia = "material"
        if params[:searchtype] == 'date'
          @vendors = MaterialVendor.where("date like ? OR created_at like ?", "%#{params[:search]}%","%#{params[:search]}%").order("created_at DESC")
        elsif params[:searchtype] == 'name'
          @material = Material.where("name like ?", "%#{params[:search]}%")[0]
          if @material != nil
            @vendors = MaterialVendor.where("material_id = ?", @material.id).order("created_at DESC")
          else
            @vendors = MaterialVendor.where("material_id = NULL").order("created_at DESC")
          end
        else
          @vendors = MaterialVendor.all.order(created_at: :desc)
        end
       end
      @vendors = @vendors.paginate(:page => params[:page], :per_page => 6)
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
    @vendortype = params[:vendortype]
    @vendoraddress = params[:vendoraddress]
    @vendorcity = params[:vendorcity]
    @vendor = Vendor.new(name: @vendorname, email: @vendoremail,address:@vendoraddress,
    city:@vendorcity,ventype:@vendortype, blacklisted: 'no')
    if @vendor.save
      render json: @vendor
    else
      puts @vendor.errors.full_messages
    end
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
