class SoldPanelsController < ApplicationController
  before_action :set_sold_panel, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404
  end
  # GET /sold_panels
  # GET /sold_panels.json
  def index
    @sold_panels = SoldPanel.all
  end

  # GET /sold_panels/1
  # GET /sold_panels/1.json
  def show
    puts @sold_panel.buyer_id
    puts "============="
    #@panel=SoldPanel.where("id= ?",@sold_panel.id)
    @buyer=Buyer.where("id= ?",@sold_panel.buyer_id)
    puts @buyer.name
    @solar_panels=SolarPanel.where("sold_panel_id= ?",@sold_panel.id)

  end

  # GET /sold_panels/new
  def new
    @sold_panel = SoldPanel.new
    @buyers=Buyer.all
    @solar_panels=SolarPanel.where(:sold_panel_id => nil)
    @disbaled=true
   
  end

  # GET /sold_panels/1/edit
  def edit
  end

  # POST /sold_panels
  # POST /sold_panels.json
  def create
    @sold_panel = SoldPanel.new(:buyer_id=> params[:buyer_id],:totalPrice=> params[:totalPrice],:totalPower=>params[:totalPower])
   

    respond_to do |format|
      if @sold_panel.save
        params[:solar_panel_id].each_with_index do |item,i|
           SolarPanel.where("id = ? ", params[:solar_panel_id][i]).update_all(:sold_panel_id => @sold_panel.id )
        end
        format.html { redirect_to @sold_panel, notice: 'Sold panel was successfully created.' }
        format.json { render :show, status: :created, location: @sold_panel }
      else
        format.html { render :new }
        format.json { render json: @sold_panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sold_panels/1
  # PATCH/PUT /sold_panels/1.json
  def update
    respond_to do |format|
      if @sold_panel.update(sold_panel_params)
        format.html { redirect_to @sold_panel, notice: 'Sold panel was successfully updated.' }
        format.json { render :show, status: :ok, location: @sold_panel }
      else
        format.html { render :edit }
        format.json { render json: @sold_panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sold_panels/1
  # DELETE /sold_panels/1.json
  def destroy
    @sold_panel.destroy
    respond_to do |format|
      format.html { redirect_to sold_panels_url, notice: 'Sold panel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sold_panel
      @sold_panel = SoldPanel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sold_panel_params
      params.require(:sold_panel).permit(:buyer_id, :totalPrice, :totalPower)
    end
end
