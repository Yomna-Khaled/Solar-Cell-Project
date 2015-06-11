class MachinesController < ApplicationController  
   skip_before_action :verify_authenticity_token
  before_action :set_machine, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
# Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404
  end
  # GET /machines
  # GET /machines.json
  def index
    if current_category.category=="Sales"or current_category.category=="Admin"
       @machines = Machine.all
    else
       render :file => "/public/404.html",:status  => "404"  
     end    
  end

  # GET /machines/1
  def show
    if false
      else
       render :file => "/public/404.html",:status  => "404"  
     end
  end

  # GET /machines/new
  def new
    if logged_in? and (current_category.category=="Sales")
      @machine = Machine.new
    else
       render :file => "/public/404.html",:status  => "404"  
     end  
  end

  # GET /machines/1/edit
  def edit
    
  end

  # POST /machines
  # POST /machines.json
  def create
    @machine = Machine.new(machine_params)

    respond_to do |format|
      if @machine.save

        format.html { redirect_to  machines_path  }
        format.json { render :show, status: :created, location: @machine }
      else
        format.html { render :new }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  def machinecreate
    @machinename=params[:machinename]
    @machine = Machine.new(name: @machinename)
    @machine.save
    render json: @machine
  end



  # PATCH/PUT /machines/1
  # PATCH/PUT /machines/1.json
  def update
    respond_to do |format|
      if @machine.update(machine_params)
        format.html { redirect_to machines_path  }
        format.json { render :show, status: :ok, location: @machine }
      else
        format.html { render :edit }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /machines/1
  # DELETE /machines/1.json
  def destroy
    if false
      @machine.destroy
      respond_to do |format|
        format.html { redirect_to machines_url }
        format.json { head :no_content }
      end
    else
       render :file => "/public/404.html",:status  => "404"  
     end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_machine
      @machine = Machine.find(params[:id])
    end
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def machine_params
      params.require(:machine).permit(:name)
    end

end
