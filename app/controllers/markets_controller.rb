class MarketsController < ApplicationController
  before_action :set_market, only: %i[ show edit update destroy ]
  
  before_action :must_be_seller_or_admin, only: %i[ my_inventory]
  # GET /markets or /markets.json
  def index
    @markets = Market.all
  end

  # GET /markets/1 or /markets/1.json
  def show
  end

  # GET /markets/new
  def new
    @market = Market.new
  end

  # GET /markets/1/edit
  def edit
  end

  # POST /markets or /markets.json
  def create
    @market = Market.new(market_params)

    respond_to do |format|
      if @market.save
        format.html { redirect_to market_url(@market), notice: "Market was successfully created." }
        format.json { render :show, status: :created, location: @market }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @market.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /markets/1 or /markets/1.json
  def update
    respond_to do |format|
      if @market.update(market_params)
        format.html { redirect_to market_url(@market), notice: "Market was successfully updated." }
        format.json { render :show, status: :ok, location: @market }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @market.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /markets/1 or /markets/1.json
  def destroy
    @market.destroy

    respond_to do |format|
      format.html { redirect_to markets_url, notice: "Market was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def my_market
    @items = Item.where(enable: true)
  end

  def my_inventory
    if must_be_seller_or_admin
      @user_login_id = User.where(id:  session[:login_user_id].to_i ).first
      @market = Market.where(user_id: @user_login_id)
    end
  end

  def inventory_edit_item
    edit_amount = params[:qty].to_i
    @item = Item.find(params[:item_id])
    @item_in_market = Market.where(item_id:@item).first
    if edit_amount >= 0 
      @item_in_market.stock = edit_amount
      @item_in_market.save
      redirect_to my_inventory_path, notice: "Amount of item has been changed"
    else 
      redirect_to my_inventory_path, notice: "Amount of item cannot be less than zero"
    end
  end

  def disable_item
    @item = Item(id:params[:item_id])
    @item.enable = false 
  end

  def inventory_add_item

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_market
      @market = Market.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def market_params
      params.require(:market).permit(:user_id, :item_id, :price, :stock)
    end
end
