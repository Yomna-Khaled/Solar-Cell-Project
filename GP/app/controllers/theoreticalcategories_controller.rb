class TheoreticalcategoriesController < ApplicationController
  before_action :set_theoreticalcategory, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404
  end

  # GET /theoreticalcategories
  def index
    if current_category.category=="Admin" or current_category.category=="Shift Manager"
      @theoreticalcategories = Theoreticalcategory.all.paginate(:page => params[:page], :per_page => 6)
   else
      render :file => "/public/404.html",:status  => "404" 
    end
  end

  # GET /theoreticalcategories/1
  def show
    if current_category.category=="Admin" or current_category.category=="Shift Manager"
      @materials_theoretical = MaterialTheoretical.where("theoreticalcategory_id=?",@theoreticalcategory.id)
    else
      render :file => "/public/404.html",:status  => "404" 
    end
  end

  # GET /theoreticalcategories/new
  def new
    if current_category.category=="Admin" or current_category.category=="Shift Manager"
      @flag_new = 1
      @materials = Material.all
      @theoreticalcategory = Theoreticalcategory.new
    else
      render :file => "/public/404.html",:status  => "404" 
    end
  end

  # GET /theoreticalcategories/1/edit
  def edit
    if current_category.category=="Admin" or current_category.category=="Shift Manager"
      @flag_new = 0
    else
      render :file => "/public/404.html",:status  => "404" 
    end  
  end

  # POST /theoreticalcategories
  def create
    if current_category.category=="Admin" or current_category.category=="Shift Manager"
      @theoreticalcategory = Theoreticalcategory.new(theoreticalcategory_params)
      respond_to do |format|
        if @theoreticalcategory.save
          last_id = Theoreticalcategory.maximum('id')
          @materials = Material.all
          @materials.each  do |material|
             @material_theoretical = MaterialTheoretical.new(:material_id => material.id, :theoreticalcategory_id => last_id, :value => params[material.name])
             @material_theoretical.save
          end
          format.html { redirect_to @theoreticalcategory }
          format.json { render :show, status: :created, location: @theoreticalcategory }
        else
          @flag_new = 1
          @materials = Material.all
          format.html { render :new }
          format.json { render json: @theoreticalcategory.errors, status: :unprocessable_entity }
        end
      end
    else
      render :file => "/public/404.html",:status  => "404" 
    end    
  end

  # PATCH/PUT /theoreticalcategories/1
  def update
    if current_category.category=="Admin" or current_category.category=="Shift Manager"
      
      respond_to do |format|
         key, value = theoreticalcategory_params.first 
         categorynamehash = {key => value}
        if @theoreticalcategory.update(categorynamehash)
            theoreticalcategory_params[:material_theoreticals_attributes].each do |m|
            @material_theoretical=MaterialTheoretical.where("theoreticalcategory_id = ? AND material_id =?" , @theoreticalcategory.id,m[1][:material_id])    
            @material_theoretical.update_all(:value => m[1][:value])
          end
     
          format.html { redirect_to @theoreticalcategory }
          format.json { render :show, status: :ok, location: @theoreticalcategory }
        else
          @flag_new = 0
          format.html { render :edit }
          format.json { render json: @theoreticalcategory.errors, status: :unprocessable_entity }
        end
      end
    else
      render :file => "/public/404.html",:status  => "404" 
    end    
  end

  # DELETE /theoreticalcategories/1
  def destroy
    if false
      @theoreticalcategory.destroy
      respond_to do |format|
        format.html { redirect_to theoreticalcategories_url }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theoreticalcategory
      @theoreticalcategory = Theoreticalcategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def theoreticalcategory_params
      params.require(:theoreticalcategory).permit(:name,material_theoreticals_attributes: [:value, :material_id])
    end
end
