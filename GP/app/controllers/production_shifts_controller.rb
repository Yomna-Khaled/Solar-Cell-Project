class ProductionShiftsController < ApplicationController
   skip_before_action :verify_authenticity_token
  before_action :set_production_shift, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404
  end
  # GET /production_shifts
  # GET /production_shifts.json
  def index
    if logged_in? and current_category.category=="Stock Keeper" 
        @production_shifts = ProductionShift.where("accepted= ?","false")
        @production_shifts.each do |m|
          puts m.material.name
          # @shift_info = Shift.where("id = ? " , m.shift_id)
          # #puts @shift_info[0].employee_id
          # @employee=Employee.where("id= ?",@shift_info[0].employee_id)
        end
    else
       render :file => "/public/404.html",:status  => "404" 
   end
  end

  # GET /production_shifts/1
  # GET /production_shifts/1.json
  def accept
     if logged_in? and current_category.category=="Stock Keeper" 
    @material=Material.where("id= ?",params[:id])

    puts params[:id]
    puts @material[0].name

    if @material[0].quantity_value < params[:quantity].to_i
         

      render plain:"ok"
    else
      @quantity=@material[0].quantity_value

      
       @production_shifts=ProductionShift.where("material_quantity= ?",params[:quantity]).
                        where("material_id= ?",params[:id]).
                        where("shift_id= ?",params[:shift]).update_all(:accepted => "true" )
      if @production_shifts
        @material.update_all(:quantity_value => @quantity-params[:quantity].to_i)
      end

       render plain:"done"                 

    end  
    else
         render :file => "/public/404.html",:status  => "404" 
    end
  end 

  def show
  end

  # GET /production_shifts/new
  def new
    if logged_in? and current_category.category=="Shift Manager" 
    @shift = Shift.where("employee_id = ?", current_user.id ).where("end_shift_date IS NULL  AND end_shift_time IS NULL") 
	    if @shift.exists?
		    @production_shift = ProductionShift.new
		    @materials = Material.all
	
	    else
			redirect_to  shifts_showstartshift_path 
	    end 
    else
         render :file => "/public/404.html",:status  => "404"
    end   
  end

  # GET /production_shifts/1/edit
  def edit
        if false 
        end

  end

  # POST /production_shifts
  # POST /production_shifts.json
  def create
    @shift=Shift.maximum("id");
    params[:material_id].each_with_index do |item,i|
      @production_shift = ProductionShift.new(:shift_id=>@shift,:material_id=> params[:material_id][i],:material_quantity=> params[params[:material_id][i]],:accepted=>"false")
      @production_shift.save
    end
   @materials = Material.all 
   redirect_to new_production_shift_path
  end


  # PATCH/PUT /production_shifts/1
  # PATCH/PUT /production_shifts/1.json
  def update
    respond_to do |format|
      if @production_shift.update(production_shift_params)
        format.html { redirect_to @production_shift }
        format.json { render :show, status: :ok, location: @production_shift }
      else
        format.html { render :edit }
        format.json { render json: @production_shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /production_shifts/1
  # DELETE /production_shifts/1.json
  def destroy
    if false
    @production_shift.destroy
    respond_to do |format|
      format.html { redirect_to production_shifts_url }
      format.json { head :no_content }
    end
  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_production_shift
      @production_shift = ProductionShift.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def production_shift_params
      params.require(:production_shift).permit(:material_id, :shift_id, :material_quantity,:accepted)
    end
end
