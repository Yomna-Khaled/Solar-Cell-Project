class BuyersController < ApplicationController
  before_action :set_buyer, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  # Render 404 page when record not found
  def render_404      
     render :file => "/public/404.html", :status => 404
  end
  # GET /buyers
  # GET /buyers.json
  def index
    if logged_in? and current_category.category=="Sales"
      @buyers = Buyer.all
      @buyers = Buyer.paginate(:page => params[:page], :per_page => 6)
    else
      render :file => "/public/404.html",:status  => "404" 
    end  
  end

  def pho
   @buyerphones_selected = BuyerPhone.where("phone = ?",params[:phone])
   @buyerphones_selected[0].destroy
  end

  # GET /buyers/1
  # GET /buyers/1.json
  def show
    if logged_in? and current_category.category=="Sales"
      @buyer_phones = BuyerPhone.where("buyer_id=?",@buyer.id)
    else
      render :file => "/public/404.html",:status  => "404" 
    end  
  end

  # GET /buyers/new
  def new
    if logged_in? and current_category.category=="Sales"
    @buyer = Buyer.new
    @flag="new"
    else
      render :file => "/public/404.html",:status  => "404"
    end
  end

  # GET /buyers/1/edit
  def edit
    if logged_in? and current_category.category=="Sales"
    @flag="edit"
    @buyer = Buyer.find(params[:id])
    @phones = BuyerPhone.where("buyer_id = ? ", @buyer.id ).select([:phone])
    else
      render :file => "/public/404.html",:status  => "404"  
    end
  end

  # POST /buyers
  # POST /buyers.json
  def create

  
  @buyer = Buyer.new(buyer_params)
      respond_to do |format|
        if @buyer.save  
          if defined? params[:buyer_phones][:phone] 
            arr= params[:buyer_phones][:phone].split(",")
            arr.each do |c|
              if c != nil
                @buyerphone = BuyerPhone.new(phone: c, buyer_id: @buyer.id) 
                @buyerphone.save  
              end
            end
          else
            
            @buyerphone = BuyerPhone.new(phone: ' ', buyer_id: @buyer.id) 
            @buyerphone.save            
          end    
          format.html { redirect_to @buyer }
          format.json { render :show, status: :created, location: @buyer }
        else
             params[:buyer_phones][:phone]==" "
            format.html { render :new }
            format.json { render json: @buyer.errors, status: :unprocessable_entity }
              
        end

  end
end


  # PATCH/PUT /buyers/1
  # PATCH/PUT /buyers/1.json

  # def update
  #   respond_to do |format|
  #     if @buyer.update(buyer_params)
  #      if params[:buyer_phones][:phone]==" "
  #        @buyerphone = BuyerPhone.new(phone: ' ', buyer_id: @buyer.id) 
  #        @buyerphone.save  
  #       else
  #        arr= params[:buyer_phones][:phone].split(",")
	 # arr.each do |c|
		# puts c	
  #          @buyerphone = BuyerPhone.new(phone: c, buyer_id: @buyer.id) 
  #          @buyerphone.save 
	 # end  
  #        end
  #       format.html { redirect_to @buyer, notice: 'Buyer was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @buyer }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @buyer.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end





#  def update
#     respond_to do |format|
#       if @buyer.update(buyer_params)
#        if params[:buyer_phones][:phone]==" "
#          @buyerphone = BuyerPhone.new(phone: ' ', buyer_id: @buyer.id) 
#          @buyerphone.save  
#         else
#          arr= params[:buyer_phones][:phone].split(",")
# 	 arr.each do |c|
# 		puts c	
#            @buyerphone = BuyerPhone.new(phone: c, buyer_id: @buyer.id) 
#            @buyerphone.save 
# 	 end  
#          end
#         format.html { redirect_to @buyer, notice: 'Buyer was successfully updated.' }
# =======
  
def update
    respond_to do |format|
      if @buyer.update(buyer_params)

      arr= params[:buyer_phones][:phone].split(",")
   arr.each do |c|
    puts c  
        if c != ""
           @buyerphone = BuyerPhone.new(phone: c, buyer_id: @buyer.id) 
           @buyerphone.save 
        end
   end    
        format.html { redirect_to @buyer }

        format.json { render :show, status: :ok, location: @buyer }
      else
        format.html { render :edit }
        format.json { render json: @buyer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buyers/1
  # DELETE /buyers/1.json
  def destroy
    if  false
      @buyer.destroy
      respond_to do |format|
        format.html { redirect_to buyers_url, notice: 'Buyer was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      render :file => "/public/404.html",:status  => "404"   
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_buyer
      @buyer = Buyer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def buyer_params
      params.require(:buyer).permit(:name, :addess, :city)
    end
    def phone_params
      params.require(:buyer).permit(:phone)
    end
end
