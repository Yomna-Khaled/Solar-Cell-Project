class SaledPanelsController < ApplicationController
  before_action :set_saled_panel, only: [:show, :edit, :update, :destroy]

  # GET /saled_panels
  # GET /saled_panels.json
  def index
    @saled_panels = SaledPanel.all
  end

  # GET /saled_panels/1
  # GET /saled_panels/1.json
  def show
  end

  # GET /saled_panels/new
  def new
    @saled_panel = SaledPanel.new
  end

  # GET /saled_panels/1/edit
  def edit
  end

  # POST /saled_panels
  # POST /saled_panels.json
  def create
    @saled_panel = SaledPanel.new(saled_panel_params)

    respond_to do |format|
      if @saled_panel.save
        format.html { redirect_to @saled_panel, notice: 'Saled panel was successfully created.' }
        format.json { render :show, status: :created, location: @saled_panel }
      else
        format.html { render :new }
        format.json { render json: @saled_panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /saled_panels/1
  # PATCH/PUT /saled_panels/1.json
  def update
    respond_to do |format|
      if @saled_panel.update(saled_panel_params)
        format.html { redirect_to @saled_panel, notice: 'Saled panel was successfully updated.' }
        format.json { render :show, status: :ok, location: @saled_panel }
      else
        format.html { render :edit }
        format.json { render json: @saled_panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saled_panels/1
  # DELETE /saled_panels/1.json
  def destroy
    @saled_panel.destroy
    respond_to do |format|
      format.html { redirect_to saled_panels_url, notice: 'Saled panel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saled_panel
      @saled_panel = SaledPanel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def saled_panel_params
      params.require(:saled_panel).permit(:solar_panel_id, :buyer_id, :totalPrice, :totalPower)
    end
end
