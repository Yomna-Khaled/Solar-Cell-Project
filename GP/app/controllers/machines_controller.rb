class MachinesController < ApplicationController  
   skip_before_action :verify_authenticity_token
  before_action :set_machine, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404
  end
  # GET /machines
  # GET /machines.json
  def index
    if current_category.category=="Sales"or current_category.category=="Admin"
       @machines = Machine.all
    else
       render :file => "/public/404.html",:status  => "404"  
     end    
  end

  # GET /machines/1
  def show
    if false
      else
       render :file => "/public/404.html",:status  => "404"  
     end
  end

  # GET /machines/new
  def new
    if logged_in? and (current_category.category=="Sales")
      @machine = Machine.new
      @vendors = Vendor.all
      @flag="new"
    else
       render :file => "/public/404.html",:status  => "404"  
     end  
  end

  # GET /machines/1/edit
  def edit
      @vendors = Vendor.all
      @machinevendor = VendorMachine.where("machine_id=? AND date IS NULL",@machine.id)
      @machinevendor_sorted = @machinevendor.order(updated_at: :desc)
      @vendor_id =  @machinevendor_sorted[0].vendor_id
      @flag="edit"
  end

  # POST /machines
  # POST /machines.json
  def create
    @machine = Machine.new(machine_params)
    @vendor_id = params['vendor'];

    respond_to do |format|
      if @machine.save
        @vendormachine = VendorMachine.new(vendor_id: @vendor_id, machine_id: @machine.id )        
        @machine_id=Machine.maximum('id')
        @machine_id = params['vendor_id'];
        @vendormachine.save
        format.html { redirect_to  machines_path  }
        format.json { render :show, status: :created, location: @machine }
      else
        @vendors = Vendor.all
        format.html { render :new }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  def machinecreate
    @machinename=params[:machinename]
    @machine = Machine.new(name: @machinename)
    @machine.save
    render json: @machine
  end



  # PATCH/PUT /machines/1
  # PATCH/PUT /machines/1.json
  def update
    @vendoredit_id = params['vendor']; #to get vendor of certain machine
    @current_vendor_record = VendorMachine.where("machine_id=? AND date IS NULL",@machine.id)
    @vendororiginal_id =@current_vendor_record[0].vendor_id

    respond_to do |format|
      if @machine.update(machine_params)
         if @vendoredit_id != @vendororiginal_id
        @record_id = @current_vendor_record[0].id
        # update last record to set end date for last vendor
        @last_machine_vendor = VendorMachine.find_by(id: @record_id)      
        @last_machine_vendor.update(date: Date.today)
        # create new record with the new vendor for this machine
        @vendormachine = VendorMachine.new(machine_id: @machine.id, vendor_id: @vendoredit_id) 
        @vendormachine.save 
        end
        format.html { redirect_to machines_path  }
        format.json { render :show, status: :ok, location: @machine }
      else
        @vendors = Vendor.all
        format.html { render :edit }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /machines/1
  # DELETE /machines/1.json
  def destroy
    if false
      @machine.destroy
      respond_to do |format|
        format.html { redirect_to machines_url }
        format.json { head :no_content }
      end
    else
       render :file => "/public/404.html",:status  => "404"  
     end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_machine
      @machine = Machine.find(params[:id])
    end
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def machine_params
      params.require(:machine).permit(:name, :serialNo)
    end

end
