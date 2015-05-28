class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show,:edit, :update, :destroy]
  before_action :end_set_shift, only: [:showendshift,:endshift] #showendshift render end view
  
  # GET /shifts
  # GET /shifts.json
  
  def report
    @shift = Shift.where("start_shift_date= ?", "2015-05-26")
    @manager = Employee.find(@shift.read_attribute("employee_id"));
    puts "----------------------"
    puts @manager

    @pannels_produced = SolarPanel.where("shift_id=?" , "1");
    #loop through @pannels_produced to sum all power and send it to the pdf

    @matirals_used = ProductionShift.where("shift_id=?" , "1");
     

    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReportPdf.new(@shift)
        send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
      end
    end
  end

  def index
    @shifts = Shift.all

    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReportPdf.new(@shifts)
        send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
      end
    end

  end

  # GET /shifts/1
  # GET /shifts/1.json
  def show
      
  end
 
  # GET /shifts/new
  def new

    @shift = Shift.new
  end

  # GET /shifts/1/edit
  def edit
  end

  # POST /shifts
  # POST /shifts.json
  def create
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
  end

  # PATCH/PUT /shifts/1
  # PATCH/PUT /shifts/1.json
  def update
    respond_to do |format|
      if @shift.update(shift_params)
        format.html { redirect_to @shift }
        format.json { render :show, status: :ok, location: @shift }
      else
        format.html { render :edit }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shifts/1
  # DELETE /shifts/1.json
  def destroy
    @shift.destroy
    respond_to do |format|
      format.html { redirect_to shifts_url }
      format.json { head :no_content }
    end
  end

  def showstartshift
    if logged_in? and current_category.category=="Shift Manager" 
     @shift = Shift.new
     @crews = Crew.all.map{|c| [c.name,c.id]} 
     if Shift.where("employee_id = ?", current_user.id ).where("end_shift_date IS NULL  AND end_shift_time IS NULL").exists?
          redirect_to  shifts_showendshift_path 
      else 
          render :showstartshift
      end 
     end
  end


  def startshift

if logged_in? and current_category.category=="Shift Manager" 
     @shift = Shift.new(start_shift_params)
     @crews = Crew.all.map{|c| [c.name,c.id]} 

    respond_to do |format|
      if @shift.save
        format.html { redirect_to @shift }
        format.json { render :show, status: :created, location: @shift }
      else
        format.html { render :showstartshift }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end 
     else
       redirect_to login_path  
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
    end 
  end

  def endshift
   if logged_in? and current_category.category=="Shift Manager"  
    respond_to do |format|
     if @shift.update(end_shift_params)

        format.html { redirect_to @shift, notice: 'Shift was successfully updated.' }
        format.json { render :show, status: :ok, location: @shift }
      else
        @inserted_panels = SolarPanel.where("shift_id = ?", @shift[0].id ).count
        format.html { render :showendshift }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
     end
   end


 else
       redirect_to login_path  
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
      params.require(:shift).permit( :crew_id,:start_shift_date,:start_shift_time).merge(:employee_id => current_user.id)
    end
    def end_shift_params
      params.require(:shift).permit(:production_rate,:end_shift_date,:end_shift_time)
    end 
    # Never trust parameters from the scary internet, only allow the white list through.
    def shift_params
      params.require(:shift).permit(:employee_id, :crew_id, :start_shift_date, :end_shift_date, :start_shift_time, :end_shift_time, :production_rate)
    end
end
