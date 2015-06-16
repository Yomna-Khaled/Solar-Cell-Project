class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
   skip_before_action :verify_authenticity_token
  # Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404,:layout => false
  end
  # GET /categories
  # GET /categories.json
  def index
    if false
      @categories = Category.all   
    else
      render :file => "/public/404.html",:status  => "404" 
    end 
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    if false
     redirect_to  @category
    else
      render :file => "/public/404.html",:status  => "404"
    end
  end

  # GET /categories/new
  def new
    if false
      @category = Category.new
    else
      render :file => "/public/404.html",:status  => "404" 
    end
  end

  # GET /categories/1/edit
  def edit
    if false
      else
      render :file => "/public/404.html",:status  => "404" 
    end
  end

  # POST /categories
  # POST /categories.json
  def create
    
       @category = Category.new(category_params)
        @category.category = @category.category.strip
        respond_to do |format|
          if @category.save
            format.html { redirect_to @category }
            format.json { render :show, status: :created, location: @category }
          else
            format.html { render :new }
            format.json { render json: @category.errors, status: :unprocessable_entity }
          end
    end
    
   
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    if  current_category.category=="noone"
      respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
    else
      render :file => "/public/404.html",:status  => "404"
    end
    
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    if false
          @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url  }
      format.json { head :no_content }
    end
    else
      render :file => "/public/404.html",:status  => "404" 
    end

  end

  def get_employees
      @employees = Employee.all
      render :partial => "employees", :object => @employees
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:category)
    end

end
