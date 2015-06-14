class CrewsController < ApplicationController
   skip_before_action :verify_authenticity_token
  before_action :set_crew, only: [:show, :edit, :update, :destroy]
  # GET /crews
  # GET /crews.json
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404
  end
  
  def index
    if current_category.category=="HR" or current_category.category=="Admin"
      @crews = Crew.where("id != ? " , "1").paginate(:page => params[:page], :per_page => 6)
    else
      render :file => "/public/404.html", :status => 404 
    end  
  end

  # GET /crews/1
  def show
    if  current_category.category=="HR" or current_category.category=="Admin"
      @crew = Crew.find(params[:id])
      @employees = Employee.where("crew_id = ?" , params[:id])
    else
      render :file => "/public/404.html", :status => 404 
    end 
  end

  # GET /crews/new
  def new
    if logged_in? and current_category.category=="HR"
      @flag_new=1
      @disabled=true
      @crew = Crew.new
      category = Category.where("category = ? " , "Normal")
      @number_of_normal_workers = Employee.where("category_id = ? " , category[0].id).count
      @crews = Crew.all
      puts(@crews.count)
    else
      render :file => "/public/404.html", :status => 404 
    end   
  end

  def get_employees
    category = Category.where("category = ? " , "Normal")
    @employees = Employee.where("category_id = ? " , category[0].id)
    puts (@employees.count)
    render partial: "employees";
  end

  # GET /crews/1/edit
  def edit
    @flag_new=0
    @disabled=false
    puts params[:id]
    @employees=Employee.where("crew_id = ?",params[:id])
    category = Category.where("category = ? " , "Normal")
    @number_of_normal_workers = Employee.where("category_id = ? " , category[0].id).count

  end

def home
 @shift = Shift.where("employee_id = ?", current_user.id ).where("end_shift_date IS NULL  AND end_shift_time IS NULL") 
  if @shift.exists?
	   @crewid = Shift.where("employee_id = ?", current_user.id ).where("end_shift_date IS NULL  AND end_shift_time IS NULL").first
	   if !@crewid 
	   	@crewid = ' ';
	    @crew_name = ' ';
	   else
	    @crew_name = Employee.where("crew_id = ? ", @crewid.crew_id ).select([:full_name])  
	   end
  else 
	   redirect_to  shifts_showstartshift_path 
  end
end

  # POST /crews
  def create
    @crew = Crew.new(crew_params)
    respond_to do |format|
      if @crew.save
          last_id = Crew.maximum('id')
          puts last_id
          array = params[:workers].split(',')
          array.each_with_index do |item,i|
              @employee = Employee.find_by(id: array[i])
              @crew_old = Crew.find_by(id: @employee.crew_id) 
              if @crew_old 
                old_number = @crew_old.no_of_workers.to_i
                if old_number != 0
                  new_number =  @crew_old.no_of_workers.to_i - 1
                  Crew.where("id = ? ", @crew_old.id).update_all(:no_of_workers =>  new_number )
                end
              end   
              if @employee 
                puts @employee.crew_id
                Employee.where("id = ? ", array[i]).update_all(:crew_id => last_id )
              end
          end
          format.html { redirect_to @crew }
          format.json { render :show, status: :created, location: @crew }
      else
        @disabled=true
        @clear = 1
        category = Category.where("category = ? " , "Normal")
        @number_of_normal_workers = Employee.where("category_id = ? " , category[0].id).count
        format.html { render :new }
        format.json { render json: @crew.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crews/1
  def update
    respond_to do |format|
    array = params[:workers].split(',') 
    Employee.where("crew_id = ? ", @crew.id).update_all(:crew_id => 1 ) 
    if @crew.update(crew_params)
        array.each_with_index do |item,i|
          @employee = Employee.find_by(id: array[i])
          if @employee 
            @crew_old = Crew.find_by(id: @employee.crew_id) 
              if @crew_old 
                old_number = @crew_old.no_of_workers.to_i
                if old_number != 0
                  new_number =  @crew_old.no_of_workers.to_i - 1
                  Crew.where("id = ? ", @crew_old.id).update_all(:no_of_workers =>  new_number )
                end
              end  
             Employee.where("id = ? ", array[i]).update_all(:crew_id => @crew.id)
          end
        end
        format.html { redirect_to @crew  }
        format.json { render :show, status: :ok, location: @crew }
    else
        @disabled=true
        @clear = 1
        format.html { render :edit }
        format.json { render json: @crew.errors, status: :unprocessable_entity }
    end
  end
end


  # DELETE /crews/1
  def destroy
    if false
      @employees = Employee.where("crew_id = ? " , @crew.id)
      @employees.each do |employee| 
        employee.update_attributes(:crew_id => NULL)
      end
      @crew.destroy
      respond_to do |format|
        format.html { redirect_to crews_url }
        format.json { head :no_content }
      end
    else
      render :file => "/public/404.html", :status => 404 
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crew
      @crew = Crew.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crew_params
      params.require(:crew).permit(:no_of_workers , :name)
    end    
end
