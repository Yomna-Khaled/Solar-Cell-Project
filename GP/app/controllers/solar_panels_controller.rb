class SolarPanelsController < ApplicationController
  before_action :set_solar_panel, only: [:show, :edit, :update, :destroy]

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
    if logged_in? and current_category.category=="Sales"
      @flag_new=1
      @solar_panel = SolarPanel.new
    else
      redirect_to login_path  
    end 

  end

  # GET /solar_panels/1/edit
  def edit
    @flag_new=0
  end

  # POST /solar_panels
  # POST /solar_panels.json
  def create
    @solar_panel = SolarPanel.new(solar_panel_params)

    respond_to do |format|
      if @solar_panel.save
        format.html { redirect_to @solar_panel, notice: 'Solar panel was successfully created.' }
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
    respond_to do |format|
      if @solar_panel.update(solar_panel_params)
        format.html { redirect_to @solar_panel, notice: 'Solar panel was successfully updated.' }
        format.json { render :show, status: :ok, location: @solar_panel }
      else
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
      format.html { redirect_to solar_panels_url, notice: 'Solar panel was successfully destroyed.' }
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
    end
end
