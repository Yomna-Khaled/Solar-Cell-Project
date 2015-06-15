class ProductionRatesController < ApplicationController
  before_action :set_production_rate, only: [:show, :edit, :update, :destroy]
 rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404
  end

  # GET /production_rates
  def index
    if current_category.category=="Admin"
      @production_rates = ProductionRate.all
    else
      render :file => "/public/404.html",:status  => "404" 
    end
  end

  # GET /production_rates/1
  def show
    if current_category.category=="Admin"
    else
      render :file => "/public/404.html",:status  => "404" 
    end  
  end

  # GET /production_rates/new
  def new
    if current_category.category=="Admin"
      @production_rate = ProductionRate.new
    else
      render :file => "/public/404.html",:status  => "404" 
    end 
  end

  # GET /production_rates/1/edit
  def edit
    if current_category.category=="Admin"
    else
      render :file => "/public/404.html",:status  => "404" 
    end   
  end

  # POST /production_rates
  def create
    if current_category.category=="Admin"
      @production_rate = ProductionRate.new(production_rate_params)
      respond_to do |format|
        if @production_rate.save
          format.html { redirect_to @production_rate }
          format.json { render :show, status: :created, location: @production_rate }
        else
          format.html { render :new }
          format.json { render json: @production_rate.errors, status: :unprocessable_entity }
        end
      end
    else
      render :file => "/public/404.html",:status  => "404" 
    end 
  end

  # PATCH/PUT /production_rates/1
  def update
    if current_category.category == "Admin"
      respond_to do |format|
        if @production_rate.update(production_rate_params)
          format.html { redirect_to @production_rate }
          format.json { render :show, status: :ok, location: @production_rate }
        else
          format.html { render :edit }
          format.json { render json: @production_rate.errors, status: :unprocessable_entity }
        end
      end
    else
      render :file => "/public/404.html",:status  => "404" 
    end 
  end

  # DELETE /production_rates/1
  def destroy
    if false
      @production_rate.destroy
      respond_to do |format|
        format.html { redirect_to production_rates_url }
        format.json { head :no_content }
      end
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_production_rate
      @production_rate = ProductionRate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def production_rate_params
      params.require(:production_rate).permit(:number_of_panels_per_hour)
    end
end
