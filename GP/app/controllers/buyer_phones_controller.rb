class BuyerPhonesController < ApplicationController
  before_action :set_buyer_phone, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
   skip_before_action :verify_authenticity_token
  # Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404,:layout => false
  end
  # GET /buyer_phones
  # GET /buyer_phones.json
  def index
    if false
      @buyer_phones = BuyerPhone.all
    else
      render :file => "/public/404.html",:status  => "404"   
    end  
  end

  # GET /buyer_phones/1
  # GET /buyer_phones/1.json
  def show
    if false
      else
      render :file => "/public/404.html",:status  => "404"   
    end
  end

  # GET /buyer_phones/new
  def new
    if false
      @buyer_phone = BuyerPhone.new
     else
      render :file => "/public/404.html",:status  => "404"   
    end
  end

  # GET /buyer_phones/1/edit
  def edit
    if false
      else
      render :file => "/public/404.html",:status  => "404"   
    end
  end

  # POST /buyer_phones
  # POST /buyer_phones.json
  def create
     if logged_in? and  ( current_category.category=="noone")
    @buyer_phone = BuyerPhone.new(buyer_phone_params)

    respond_to do |format|
      if @buyer_phone.save
        format.html { redirect_to @buyer_phone, notice: 'Buyer phone was successfully created.' }
        format.json { render :show, status: :created, location: @buyer_phone }
      else
        format.html { render :new }
        format.json { render json: @buyer_phone.errors, status: :unprocessable_entity }
      end
    end
    else
      render :file => "/public/404.html",:status  => "404"   
    end
  end

  # PATCH/PUT /buyer_phones/1
  # PATCH/PUT /buyer_phones/1.json
  def update
    respond_to do |format|
      if @buyer_phone.update(buyer_phone_params)
        format.html { redirect_to @buyer_phone, notice: 'Buyer phone was successfully updated.' }
        format.json { render :show, status: :ok, location: @buyer_phone }
      else
        format.html { render :edit }
        format.json { render json: @buyer_phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buyer_phones/1
  # DELETE /buyer_phones/1.json
  def destroy
    if false
    @buyer_phone.destroy
    respond_to do |format|
      format.html { redirect_to buyer_phones_url, notice: 'Buyer phone was successfully destroyed.' }
      format.json { head :no_content }
    end
    else
      render :file => "/public/404.html",:status  => "404"   
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_buyer_phone
      @buyer_phone = BuyerPhone.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def buyer_phone_params
      params.require(:buyer_phone).permit(:buyer_id, :phone)
    end
end
