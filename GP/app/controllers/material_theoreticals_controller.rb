class MaterialTheoreticalsController < ApplicationController
  before_action :set_material_theoretical, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404
  end

  # GET /material_theoreticals
  def index
    if  false 
       @material_theoreticals = MaterialTheoretical.all
    else
      render :file => "/public/404.html",:status  => "404" 
    end  
  end

  # GET /material_theoreticals/1
  def show
    if  false
      else
      render :file => "/public/404.html",:status  => "404" 
    end
  end

  # GET /material_theoreticals/new
  def new
    if  false
       @material_theoretical = MaterialTheoretical.new
    else
      render :file => "/public/404.html",:status  => "404" 
    end  
  end

  # GET /material_theoreticals/1/edit
  def edit
    if  false
      else
      render :file => "/public/404.html",:status  => "404" 
    end
  end

  # POST /material_theoreticals
  def create
    @material_theoretical = MaterialTheoretical.new(material_theoretical_params)
    respond_to do |format|
      if @material_theoretical.save
        format.html { redirect_to @material_theoretical }
        format.json { render :show, status: :created, location: @material_theoretical }
      else
        format.html { render :new }
        format.json { render json: @material_theoretical.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /material_theoreticals/1
  # PATCH/PUT /material_theoreticals/1.json
  def update
    respond_to do |format|
      if @material_theoretical.update(material_theoretical_params)
        format.html { redirect_to @material_theoretical, notice: 'Material theoretical was successfully updated.' }
        format.json { render :show, status: :ok, location: @material_theoretical }
      else
        format.html { render :edit }
        format.json { render json: @material_theoretical.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /material_theoreticals/1
  # DELETE /material_theoreticals/1.json
  def destroy
    if false
      @material_theoretical.destroy
      respond_to do |format|
        format.html { redirect_to material_theoreticals_url, notice: 'Material theoretical was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      render :file => "/public/404.html",:status  => "404" 
    end       
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material_theoretical
      @material_theoretical = MaterialTheoretical.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def material_theoretical_params
      params.require(:material_theoretical).permit(:value)
    end
end
