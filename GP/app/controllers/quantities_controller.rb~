class QuantitiesController < ApplicationController
  before_action :set_quantity, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404
  end
  # GET /quantities
  # GET /quantities.json
  def index
    if false
      @quantities = Quantity.all
    else
      render :file => "/public/404.html",:status  => "404"  
    end  
  end

  # GET /quantities/1
  # GET /quantities/1.json
  def show
    if false
      else
      render :file => "/public/404.html",:status  => "404"  
    end
  end

  # GET /quantities/new
  def new
    if false
      @quantity = Quantity.new
    else
      render :file => "/public/404.html",:status  => "404"  
    end

  end

  # GET /quantities/1/edit
  def edit
    if false
      else
      render :file => "/public/404.html",:status  => "404"  
    end
  end

  # POST /quantities
  # POST /quantities.json
  def create
    puts "=================="
    @unitname=params[:unitname]
    @quantity = Quantity.new(unit_name: @unitname)
    @quantity.save
    render json: @quantity
  end

  # PATCH/PUT /quantities/1
  # PATCH/PUT /quantities/1.json
  def update
    respond_to do |format|
      if @quantity.update(quantity_params)
        format.html { redirect_to @quantity }
        format.json { render :show, status: :ok, location: @quantity }
      else
        format.html { render :edit }
        format.json { render json: @quantity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quantities/1
  # DELETE /quantities/1.json
  def destroy
    if false
      @quantity.destroy
      respond_to do |format|
        format.html { redirect_to quantities_url }
        format.json { head :no_content }
      end
    else
      render :file => "/public/404.html",:status  => "404"  
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quantity
      @quantity = Quantity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quantity_params
      params.require(:quantity).permit(:unit_name)
    end
end
