class SolarPanelsController < ApplicationController
  before_action :set_solar_panel, only: [:show, :edit, :update, :destroy]
  before_action  :set_controller_serial_ids,only:[:new,:create,:edit,:update]
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404
  end
  # GET /solar_panels
  

  def index
    if current_category.category=="Sales" or current_category.category=="Admin"
      if params[:search]
        if params[:searchcriteria] == 'serialno'
          @solar_panels = SolarPanel.searchserialno(params[:search],params[:soldornot]).order("created_at DESC")
        else
          @solar_panels = SolarPanel.searchpower(params[:search],params[:soldornot]).order("created_at DESC")
        end
      else
       @solar_panels = SolarPanel.all
       @solar_panels = SolarPanel.paginate(:page => params[:page], :per_page => 6)
     end
    else
      render :file => "/public/404.html",:status  => "404" 
    end   
  end

  # GET /solar_panels/1
  def show
    if current_category.category=="Sales" or current_category.category=="Shift Manager" or current_category.category=="Admin"
    else
       render :file => "/public/404.html",:status  => "404" 
    end
  end

  # GET /solar_panels/new
  def new
    if logged_in? and( current_category.category=="Shift Manager" )
      @flag= true
      @solar_panel  = SolarPanel.new
      @shift = Shift.where("employee_id = ?", current_user.id ).where("end_shift_date IS NULL  AND end_shift_time IS NULL")
      if @shift.exists? 
      else 
        redirect_to url_for(:controller => :shifts, :action => :showstartshift) 
      end
    else
        render :file => "/public/404.html",:status  => "404"
    end 
  end

  # GET /solar_panels/1/edit


 def edit
    @flag=false
     if logged_in? and( current_category.category=="Shift Manager" ) 
        @container=Container.find(@solar_panel.container_id)
        @mycrt=[@container.serialNo,@container.id]
        unless @containersopt.include?(@mycrt)
           @containersopt.push(@mycrt)
        end
     else
          render :file => "/public/404.html",:status  => "404" 
     end 
 end

  # POST /solar_panels
  def create
    if logged_in? and( current_category.category=="Shift Manager" )
      @flag=true
	    @shift = Shift.where("employee_id = ?", current_user.id ).where("end_shift_date IS NULL  AND end_shift_time IS NULL")
      @solar_panel = SolarPanel.new(solar_panel_params.merge!(:shift_id =>@shift.first.id,:price=>(LookupPrice.where("name=?","watt").first.value)*solar_panel_params[:power].to_f),:power=>solar_panel_params[:power].to_f) 
	    respond_to do |format|
	      if @solar_panel.save
               @shift[0].update_attributes(:production_rate => ((@shift[0].production_rate)+1))  
               @container=Container.find(@solar_panel.container_id)
  	       @power=@container.total_power+@solar_panel.power 
  	       @container.update_attributes(:total_power => @power)
  	       format.html { redirect_to  shifts_currentshift_path  }
  	       format.json { render :show, status: :created, location: @solar_panel }
	      else
        		format.html { render :new }
        		format.json { render json: @solar_panel.errors, status: :unprocessable_entity }
	      end
	    end
    end
  
  end

  # PATCH/PUT /solar_panels/1
  def update
    @flag=false   
    respond_to do |format|
        if logged_in? and( current_category.category=="Shift Manager" )
            @old_solar_panel=SolarPanel.find(params[:id])
            @oldcontainer=Container.find(@old_solar_panel.container_id)
            @power=@oldcontainer.total_power-@old_solar_panel.power 
            @oldcontainer.update_attributes(:total_power => @power)
            if @solar_panel.update(solar_panel_params.merge!(:price=>(LookupPrice.where("name=?","watt").first.value)*solar_panel_params[:power].to_f))
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
  end

  # DELETE /solar_panels/1
  def destroy
    if false
    @solar_panel.destroy
    respond_to do |format|
      format.html { redirect_to solar_panels_url }
      format.json { head :no_content }
    end
    else
       redirect_to login_path 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_solar_panel
      @solar_panel = SolarPanel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def solar_panel_params
      params.require(:solar_panel).permit(:production_date, :expire_date, :height, :width, :power,:cellno, :celltype, :subtype, :serialNo, :container_id)
    end

    def solar_Salespanel_params
      params.require(:solar_panel).permit(:price)
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
