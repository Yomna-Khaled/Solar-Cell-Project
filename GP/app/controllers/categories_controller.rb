class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  # Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404
  end
  # GET /categories
  # GET /categories.json
  def index
    if  current_category.category=="noone"
      @categories = Category.all   
    else
      redirect_to login_path  
    end 
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    if  current_category.category=="noone"
     redirect_to  @category
    else
      redirect_to login_path 
    end
  end

  # GET /categories/new
  def new
    if  current_category.category=="noone"
      @category = Category.new
    else
      redirect_to login_path 
    end
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    if  current_category.category=="noone"
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
    else
      redirect_to login_path 
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
      redirect_to login_path 
    end
    
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    if  current_category.category=="noone"
          @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url  }
      format.json { head :no_content }
    end
    else
      redirect_to login_path 
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
