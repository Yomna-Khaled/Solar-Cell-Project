class SalesAdminsController < ApplicationController
  before_action :set_sales_admin, only: [:show, :edit, :update, :destroy]

  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  # GET /sales_admins
  # GET /sales_admins.json
  def index
     if logged_in? and( current_category.category=="Admin" )
    @sales_admins = SalesAdmin.all
  else
      render :file => "/public/404.html",:status  => "404"
  end

  end

  # GET /sales_admins/1
  # GET /sales_admins/1.json
  def show
    if false
     else
      render :file => "/public/404.html",:status  => "404"
    end
      
  end

  # GET /sales_admins/new
  def new
   if logged_in? and( current_category.category=="Sales" )
    @sales_admin = SalesAdmin.new
  else
      render :file => "/public/404.html",:status  => "404"
  end
  end

  # GET /sales_admins/1/edit
  def edit
    if false
    else
       render :file => "/public/404.html",:status  => "404" 
    end  
  end

  # POST /sales_admins
  # POST /sales_admins.json
  def create
   
    @sales_admin = SalesAdmin.new(sales_admin_params)

    respond_to do |format|
      if @sales_admin.save
        format.html { redirect_to @sales_admin, notice: 'Sales admin was successfully created.' }
        format.json { render :show, status: :created, location: @sales_admin }
      else
        format.html { render :new }
        format.json { render json: @sales_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales_admins/1
  # PATCH/PUT /sales_admins/1.json
  def update
    respond_to do |format|
      if @sales_admin.update(sales_admin_params)
        format.html { redirect_to @sales_admin, notice: 'Sales admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @sales_admin }
      else
        format.html { render :edit }
        format.json { render json: @sales_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales_admins/1
  # DELETE /sales_admins/1.json
  def destroy
    if false
    @sales_admin.destroy
    respond_to do |format|
      format.html { redirect_to sales_admins_url, notice: 'Sales admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  else
      render :file => "/public/404.html",:status  => "404"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sales_admin
      @sales_admin = SalesAdmin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sales_admin_params
      params.require(:sales_admin).permit(:power, :celltype, :subtype)
    end
end
