class LookupPricesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_lookup_price, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404
  end
  # GET /lookup_prices
  # GET /lookup_prices.json
  def index
    if current_category.category=="Sales" or current_category.category=="Admin"
      @lookup_prices = LookupPrice.all
    else
       render :file => "/public/404.html",:status  => "404"  
     end  
  end

  # GET /lookup_prices/1
  # GET /lookup_prices/1.json
  def show
     if current_category.category=="Sales" or current_category.category=="Admin"
     else
       render :file => "/public/404.html",:status  => "404"  
     end
  end

  # GET /lookup_prices/new
  def new
    if false
       @lookup_price = LookupPrice.new
    else
       render :file => "/public/404.html",:status  => "404" 
    end
  end

  # GET /lookup_prices/1/edit
  def edit
      if current_category.category=="Sales" or current_category.category=="Admin"
     else
       render :file => "/public/404.html",:status  => "404" 
     end
  end

  # POST /lookup_prices
  # POST /lookup_prices.json
  def create
    @lookup_price = LookupPrice.new(lookup_price_params)
    respond_to do |format|
      if @lookup_price.save
        format.html { redirect_to @lookup_price, notice: 'Lookup price was successfully created.' }
        format.json { render :show, status: :created, location: @lookup_price }
      else
        format.html { render :new }
        format.json { render json: @lookup_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lookup_prices/1
  # PATCH/PUT /lookup_prices/1.json
  def update
    respond_to do |format|
      if @lookup_price.update(lookup_price_params)
         @unsoldpanels=SolarPanel.where("sold_panel_id is NULL")
         
         for i in 0...(@unsoldpanels).length

                 @unsoldpanels[i].update_attributes(:price=>(LookupPrice.where("name=?","watt").first.value)*@unsoldpanels[i][:power].to_f)
         end
        format.html { redirect_to lookup_prices_path , notice: 'Lookup price was successfully updated.' }
        format.json { render :show, status: :ok, location: @lookup_price }
      else
        format.html { render :edit }
        format.json { render json: @lookup_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lookup_prices/1
  # DELETE /lookup_prices/1.json
  def destroy
    if false
      @lookup_price.destroy
      respond_to do |format|
        format.html { redirect_to lookup_prices_url, notice: 'Lookup price was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
       render :file => "/public/404.html",:status  => "404"  
     end   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lookup_price
      @lookup_price = LookupPrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lookup_price_params
      params.require(:lookup_price).permit(:value)
    end
end
