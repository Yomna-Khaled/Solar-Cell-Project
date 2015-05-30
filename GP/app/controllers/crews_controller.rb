class CrewsController < ApplicationController
  before_action :set_crew, only: [:show, :edit, :update, :destroy]
  # GET /crews
  # GET /crews.json
  def index
    if logged_in? and current_category.category=="HR"
      @crews = Crew.all
    else
      redirect_to login_path  
    end  
  end

  # GET /crews/1
  def show
    @crew = Crew.find(params[:id])
    @employees = Employee.where("crew_id = ?" , params[:id])
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
      redirect_to login_path  
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
   @crewid = Shift.where("employee_id = ?", current_user.id ).where("end_shift_date IS NULL  AND end_shift_time IS NULL").first
   if !@crewid 
   	@crewid = ' ';
    @crew_name = ' ';
   else
    @crew_name = Employee.where("crew_id = ? ", @crewid.crew_id ).select([:full_name])  
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
              puts array[i]
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
          @employee_old = Employee.find_by(crew_id: @crew.id) 
          Employee.where("id = ? ", @employee_old.id).update_all(:crew_id => 107 ) 
          if @crew.update(crew_params)
              array.each_with_index do |item,i|
                  @employee = Employee.find_by(id: array[i])
                  if @employee 
                       Employee.where("id = ? ", array[i]).update_all(:crew_id => @crew.id)
                  end
              end
              format.html { redirect_to @crew  }
              format.json { render :show, status: :ok, location: @crew }
          else
            format.html { render :edit }
            format.json { render json: @crew.errors, status: :unprocessable_entity }
          end
      end
  end


  # DELETE /crews/1
  def destroy
    @employees = Employee.where("crew_id = ? " , @crew.id)
    #render plain: @employees

    @employees.each do |employee| 
      employee.update_attributes(:crew_id => NULL)
    end
    @crew.destroy
    respond_to do |format|
      format.html { redirect_to crews_url }
      format.json { head :no_content }
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
