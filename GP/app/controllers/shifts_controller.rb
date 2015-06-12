class ShiftsController < ApplicationController
   skip_before_action :verify_authenticity_token
  before_action :set_shift, only: [:show,:edit, :update, :destroy]
  before_action :end_set_shift, only: [:showendshift,:endshift] #showendshift render end view
  before_action  :set_controller_serial_ids,only:[:currentshift]
   
  # GET /shifts
  # GET /shifts.json
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404
  end

  def allshifts
    if current_category.category=="Admin"
      @shifts = Shift.all
      @shifts = Shift.paginate(:page => params[:page], :per_page => 6)
    else
      render :file => "/public/404.html",:status  => "404" 
    end   
  end  
   
  def report

      if  current_category.category=="Shift Manager" or current_category.category=="Admin"
	    puts params[:id]

	    @total_power=0
	    @shift = Shift.where("id = ? ", params[:id])
	    if @shift[0].end_shift_date != nil 
            @shift_produced_rate = @shift[0].production_rate

	    @manager = current_user.full_name
	    @crew_member_numbers = Crew.find(@shift[0].crew_id)
	    @crew_Members = Employee.where("crew_id = ? " , @shift[0].crew_id)
	    @solar_panels=SolarPanel.where("shift_id = ?" , @shift[0].id)

	    @solar_panels.each do|solar|
	      @total_power = @total_power + solar.power
	    end
	  
	     @materials_used_id= ProductionShift.where("shift_id = ? " , params[:id] )
	    puts "==============================================="
       @materials_used_id.each do |m|
      		puts m.material.name
      		puts m.material_quantity
	     end
	    puts "==============================================="
	    respond_to do |format|
	      format.html
	      format.pdf do
		pdf = ReportPdf.new(@shift ,@manager ,@crew_member_numbers , @shift_produced_rate , @total_power , @materials_used_id , @crew_Members)
		send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
	      end
	    end
	  else 
	      redirect_to   shifts_showendshift_path 
	  end
    else
      render :file => "/public/404.html",:status  => "404" 
    end 
  end

  def index
   if logged_in? and current_category.category=="Shift Manager"
    @shifts = Shift.where("employee_id = ?" , current_user.id )
    @shifts = Shift.paginate(:page => params[:page], :per_page => 6)
    @manager = current_user.full_name
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReportPdf.new(@shifts,@manager)
        send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
      end
    end
    else
      render :file => "/public/404.html",:status  => "404"  
    end 
  end

  # GET /shifts/1
  # GET /shifts/1.json
  def show
     if current_category.category=="Shift Manager" or current_category.category=="Admin"
     else
      render :file => "/public/404.html",:status  => "404" 
    end   
  end
 
  # GET /shifts/new
  def new
    if false 
      @shift = Shift.new
    else
      render :file => "/public/404.html",:status  => "404"    
    end
  end

  # GET /shifts/1/edit
  def edit
     if false 
      
    else
      render :file => "/public/404.html",:status  => "404"    
    end
  end



  # POST /shifts
  # POST /shifts.json
  def create
      if false
	    @shift = Shift.new(shift_params)

	    respond_to do |format|
	      if @shift.save
		format.html { redirect_to @shift }
		format.json { render :show, status: :created, location: @shift }
	      else
		format.html { render :new }
		format.json { render json: @shift.errors, status: :unprocessable_entity }
	      end
	    end
     else
       render :file => "/public/404.html",:status  => "404"  
     end 
  end

  # PATCH/PUT /shifts/1
  # PATCH/PUT /shifts/1.json
  def update
    if false
	    respond_to do |format|
	      if @shift.update(shift_params)
		format.html { redirect_to @shift }
		format.json { render :show, status: :ok, location: @shift }
	      else
		format.html { render :edit }
		format.json { render json: @shift.errors, status: :unprocessable_entity }
	      end
	    end
     else
       render :file => "/public/404.html",:status  => "404"   
     end 
  end

  # DELETE /shifts/1
  # DELETE /shifts/1.json
  def destroy
    if false
	    @shift.destroy
	    respond_to do |format|
	      format.html { redirect_to shifts_url }
	      format.json { head :no_content }
	    end
     else
       render :file => "/public/404.html",:status  => "404"   
     end 
  end

  def showstartshift
     if logged_in? and current_category.category=="Shift Manager" 
	     @shift = Shift.new
	     @crews = Crew.where("id != ? AND no_of_workers > ?", "1","0").map{|c| [c.name,c.id]} 
             
	     if Shift.where("employee_id = ?", current_user.id ).where("end_shift_date IS NULL  AND end_shift_time IS NULL").exists?
		  redirect_to  shifts_showendshift_path 
	     else 
		  render :showstartshift
	     end 
     else
      render :file => "/public/404.html",:status  => "404" 
     end 
  end


  def startshift

if current_category.category=="Shift Manager" 
     @shift = Shift.new(start_shift_params)
      
           respond_to do |format|
	      if @shift.save
                session[:shift_id] = @shift.id
                format.html { redirect_to  shifts_currentshift_path  }
		format.json { render :show, status: :created, location: @shift }
	      else
                @crews = Crew.where("id != ? AND no_of_workers > ?", "1","0").map{|c| [c.name,c.id]} 
		format.html { render :showstartshift }
		format.json { render json: @shift.errors, status: :unprocessable_entity }
	      end
	    end 
     else
       render :file => "/public/404.html",:status  => "404"  
     end 
    

  end

  def showendshift
    if logged_in? and current_category.category=="Shift Manager"  
     @shift = Shift.where("employee_id = ?", current_user.id ).where("end_shift_date IS NULL  AND end_shift_time IS NULL") 
     
     if @shift.exists?
      @shift = @shift.first 
      @inserted_panels = SolarPanel.where("shift_id = ?", @shift.id ).count
      render :showendshift
     else 
      redirect_to  shifts_showstartshift_path 
     end
    else
       render :file => "/public/404.html",:status  => "404" 
    end 
   
   
  end

  def endshift
   if logged_in? and current_category.category=="Shift Manager"
            @unacceptedshifts=ProductionShift.where(@shift.id)
             for i in 0..(@unacceptedshifts.all.length-1)
                 if (@unacceptedshifts[i].accepted == "false")
                     @unacceptedshifts[i].destroy  
                 end
             end   
	    respond_to do |format|
	     if @shift.update(end_shift_params)

		format.html { redirect_to shifts_path }
		format.json { render :show, status: :ok, location: @shift }
	      else
		@inserted_panels = SolarPanel.where("shift_id = ?", @shift[0].id ).count
		format.html { render :showendshift }
		format.json { render json: @shift.errors, status: :unprocessable_entity }
	     end
	   end


    else
       render :file => "/public/404.html",:status  => "404"  
     end

  end
    def currentshift
      
      if logged_in? and current_category.category=="Shift Manager"
             
	     @solar_panel = SolarPanel.new
             @shift = Shift.where("employee_id = ?", current_user.id ).where("end_shift_date IS NULL  AND end_shift_time IS NULL") 
	     if @shift.exists?
		     @shift = @shift.first
                     @crewid =@shift.crew_id
		     if !@crewid 
	   	        @crewid = ' ';
		        @crew_name = ' ';
		     else
		        @crew_name = Employee.where("crew_id = ? ", @crewid ).select([:full_name])  
		     end  
		      
             else 
	              redirect_to  shifts_showstartshift_path 
	     end
    else
       render :file => "/public/404.html",:status  => "404"
    end 
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shift
      @shift = Shift.find(params[:id])
      
    end
    def end_set_shift
      @shift = Shift.where("employee_id = ?", current_user.id ).where("end_shift_date IS NULL  AND end_shift_time IS NULL").first
    end
   
    def start_shift_params
      params[:shift][:start_shift_time]=Time.zone.now
      params[:shift][:end_shift_Date] =Time.zone.now.strftime('%d %b %Y')
      #params[:shift][:start_shift_time] =Time.now.strftime('%a, %d %b %Y %H:%M:%S')
      params.require(:shift).permit( :crew_id,:start_shift_date,:start_shift_time).merge(:employee_id => current_user.id)
    end
    def end_shift_params
       params[:shift][:end_shift_time]=Time.zone.now
       params[:shift][:end_shift_Date] =Time.zone.now.strftime('%d %b %Y')
       params.require(:shift).permit(:production_rate,:end_shift_date,:end_shift_time)
    end 

    # Never trust parameters from the scary internet, only allow the white list through.
    def shift_params
      params.require(:shift).permit(:employee_id, :crew_id, :start_shift_date, :end_shift_date, :start_shift_time, :end_shift_time, :production_rate)
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
