class SolarPanelsController < ApplicationController
  before_action :set_solar_panel, only: [:show, :edit, :update, :destroy]
  before_action  :set_controller_serial_ids,only:[:new,:create,:edit,:update]

  # GET /solar_panels
  # GET /solar_panels.json
  def index
    if logged_in? and current_category.category=="Sales"
       @solar_panels = SolarPanel.all
    else
      redirect_to login_path  
    end   
  end

  # GET /solar_panels/1
  # GET /solar_panels/1.json
  def show
  end

  # GET /solar_panels/new
  def new

if logged_in? and (current_category.category=="Shift Manager" or  current_category.category=="Sales")
     @flag_new=1
     @flag=false
     @solar_panel  = SolarPanel.new
     @shift = Shift.where("employee_id = ?", current_user.id ).where("end_shift_date IS NULL  AND end_shift_time IS NULL")
     if @shift.exists? 
     else 
       redirect_to url_for(:controller => :shifts, :action => :showstartshift) 
     end
     else
      redirect_to login_path  
    end 
  end

  # GET /solar_panels/1/edit
  def edit
    @flag_new=0
    @flag=true
    @container=Container.find(@solar_panel.container_id)
    @mycrt=[@container.serialNo,@container.id]
    unless @containersopt.include?(@mycrt)
       @containersopt.push(@mycrt)
    end 
 end

  # POST /solar_panels
  # POST /solar_panels.json
  def create
    @flag=false
    @shift = Shift.where("employee_id = ?", current_user.id ).where("end_shift_date IS NULL  AND end_shift_time IS NULL")
    @solar_panel = SolarPanel.new(solar_panel_params.merge!(:shift_id =>@shift.first.id))
     
    respond_to do |format|
      if @solar_panel.save


       @container=Container.find(@solar_panel.container_id)
       @power=@container.total_power+@solar_panel.power 
       @container.update_attributes(:total_power => @power)
       format.html { render :show }
       format.json { render :show, status: :created, location: @solar_panel }
      else
        format.html { render :new }
        format.json { render json: @solar_panel.errors, status: :unprocessable_entity }
      end
    end
    
 end

  # PATCH/PUT /solar_panels/1
  # PATCH/PUT /solar_panels/1.json
  def update
    @flag=true
    respond_to do |format|
      @old_solar_panel=SolarPanel.find(params[:id])
      @oldcontainer=Container.find(@old_solar_panel.container_id)
      @power=@oldcontainer.total_power-@old_solar_panel.power 
      @oldcontainer.update_attributes(:total_power => @power)
     
      if @solar_panel.update(solar_panel_params)
        @container=Container.find(@solar_panel.container_id)     
        @power=@container.total_power+@solar_panel.power 
        @container.update_attributes(:total_power => @power)
       
        format.html { redirect_to @solar_panel, notice: 'Solar panel was successfully updated.' }
        format.json { render :show, status: :ok, location: @solar_panel }
      else
        @container=Container.find(@solar_panel.container_id)
	@mycrt=[@container.serialNo,@container.id]
	unless @containersopt.include?(@mycrt)
	       @containersopt.push(@mycrt)
	end 
        format.html { render :edit }
        format.json { render json: @solar_panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /solar_panels/1
  # DELETE /solar_panels/1.json
  def destroy
    @solar_panel.destroy
    respond_to do |format|
      format.html { redirect_to solar_panels_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_solar_panel
      @solar_panel = SolarPanel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def solar_panel_params

      params.require(:solar_panel).permit(:production_date, :expire_date, :height, :width, :power, :celltype, :subtype, :price, :serialNo, :container_id)

      @solarhash=params.require(:solar_panel).permit(:production_date, :height, :width, :power, :celltype, :subtype, :price, :serialNo, :container_id)
      
         

    end
    def set_controller_serial_ids
         @containersopt=[]       
     for i in 0..(Container.all.length-1)
       @containerid = (Container.all)[i].id
       @crtcap=SolarPanel.where("container_id = ?", @containerid ).count
       @empcap=Container.where("id = ? AND capacity > ?",@containerid,@crtcap)
       if (@empcap.exists?)
         @myarr = [@empcap[0].serialNo,@empcap[0].id]
         @containersopt.push(@myarr)
       end
     end
        
    end
end
