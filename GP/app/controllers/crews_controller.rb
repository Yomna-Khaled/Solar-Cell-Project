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
      @crew = Crew.new
    else
      redirect_to login_path  
    end   
  end

  def get_employees
    @employees = Employee.all
    puts "++++++++++++++++++++++++++++++++++++++++++++++++"
    render partial: "employees";
  end

  # GET /crews/1/edit
  def edit
    @flag_new=0
  end

  # POST /crews
  def create
    @crew = Crew.new(crew_params)

    respond_to do |format|
    
      if @crew.save
        last_id = Crew.maximum('id')
        array = params[:workers].split(',')

        array.each_with_index do |item,i|

           @employee = Employee.find_by(id: array[i])
            if @employee 
                  @employee.update_attributes(:crew_id => last_id)
            end
        end
    
        format.html { redirect_to @crew, notice: 'Crew was successfully created.' }
        format.json { render :show, status: :created, location: @crew }
      else
        format.html { render :new }
        format.json { render json: @crew.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crews/1
  def update
    respond_to do |format|
      if @crew.update(crew_params)
        format.html { redirect_to @crew, notice: 'Crew was successfully updated.' }
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
      format.html { redirect_to crews_url, notice: 'Crew was successfully destroyed.' }
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
