class LookupPricesController < ApplicationController
  before_action :set_lookup_price, only: [:show, :edit, :update, :destroy]

  # GET /lookup_prices
  # GET /lookup_prices.json
  def index
    @lookup_prices = LookupPrice.all
  end

  # GET /lookup_prices/1
  # GET /lookup_prices/1.json
  def show
  end

  # GET /lookup_prices/new
  def new
    @lookup_price = LookupPrice.new
  end

  # GET /lookup_prices/1/edit
  def edit
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
        format.html { redirect_to @lookup_price, notice: 'Lookup price was successfully updated.' }
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
    @lookup_price.destroy
    respond_to do |format|
      format.html { redirect_to lookup_prices_url, notice: 'Lookup price was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lookup_price
      @lookup_price = LookupPrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lookup_price_params
      params.require(:lookup_price).permit(:name, :value)
    end
end
