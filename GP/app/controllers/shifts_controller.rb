class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]

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
        format.html { redirect_to @shift, notice: 'Shift was successfully created.' }
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
        format.html { redirect_to @shift, notice: 'Shift was successfully updated.' }
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
      format.html { redirect_to shifts_url, notice: 'Shift was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shift
      @shift = Shift.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shift_params
      params.require(:shift).permit(:employee_id, :crew_id, :start_shift_date, :end_shift_date, :start_shift_time, :end_shift_time, :production_rate)
    end
end
