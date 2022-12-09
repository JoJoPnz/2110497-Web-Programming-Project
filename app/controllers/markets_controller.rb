class MarketsController < ApplicationController
  before_action :set_market, only: %i[ show edit update destroy ]
  before_action :must_be_buyer_or_admin, only: %i[ my_market purchase_item ]
  before_action :must_be_seller_or_admin, only: %i[ my_inventory inventory_add_item added_item_from_inventory]

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

  # ==============================
  def my_market
    @items = Item.where(enable: true)
  end

  def purchase_item
    @qty = params[:qty].to_i
    @item_id = params[:item_id].to_i
    @buyer_id = get_login_user.id
    @market = Market.where(item_id: @item_id).first
    @price = @market.price
    @stock = @market.stock
    
    if @qty <= 0
      redirect_to my_market_path, error: 'quantity must be greater than 0'
    elsif @stock < @qty
      redirect_to my_market_path, error: 'item stock is less than the quantity you want to buy'
    else
      @item = Item.find(@item_id)
      @remaining_stock = @stock - @qty
      @market.update(stock: @remaining_stock)
      Inventory.create(user_id: @buyer_id, item_id: @item_id, price: @price, qty: @qty, timestamp: DateTime.now)
      redirect_to my_market_path, success: 'purchase ' + @qty.to_s + ' ' + @item.name.to_s + ' successfully'
    end
  end

  def my_inventory
    @user_login_id = User.where(id:  session[:login_user_id].to_i ).first
    @market = Market.where(user_id: @user_login_id)
  end
  
  def inventory_edit_item
    edit_amount = params[:qty].to_i
    @item = Item.find(params[:item_id])
    @item_in_market = Market.where(item_id:@item).first
    if edit_amount >= 0 
      @item_in_market.stock = edit_amount
      @item_in_market.save
      redirect_to my_inventory_path, success: "Amount of item has been changed"
    else 
      redirect_to my_inventory_path, error: "Amount of item cannot be less than zero"
    end
  end

  def disable_item
    @item = Item.where(id:params[:item_id]).first
    @item.enable = false 
    @item.save
    redirect_to '/my_inventory', notice: "The item has been deleted"
  end

  def inventory_add_item

  end

  def added_item_from_inventory
    @price = params[:price].to_f
    @stock = params[:stock].to_i
    @name = params[:name]
    @category = params[:category]
    if(@price.blank? || @stock.blank? || @name.blank? || @category.blank? )
      redirect_to '/inventory_add_item', alert: "name, category, price, stock must be filled"
    elsif(@stock < 0)
      redirect_to '/inventory_add_item', alert: "stock is not allowed to be less than zero" 
    elsif(@price <= 0)
      redirect_to '/inventory_add_item', alert: "price is not allowed to be zero or less than zero"  
    else
        @enable = params[:enable]
        @picture = params[:picture]
        temp = Item.create(name:@name , category:@category, enable:@enable, picture:@picture)
        Market.create(user_id:get_login_user.id , item_id:temp.id , price:@price, stock:@stock)
        redirect_to '/my_inventory', success: "The item has been added"
    end
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
