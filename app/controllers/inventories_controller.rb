class InventoriesController < ApplicationController
  before_action :set_inventory, only: %i[ show edit update destroy ]
  before_action :must_be_buyer_or_admin, only: %i[ purchase_history ]
  before_action :must_be_seller_or_admin, only: %i[ sale_history ]

  # GET /inventories or /inventories.json
  def index
    @inventories = Inventory.all
  end

  # GET /inventories/1 or /inventories/1.json
  def show
  end

  # GET /inventories/new
  def new
    @inventory = Inventory.new
  end

  # GET /inventories/1/edit
  def edit
  end

  # POST /inventories or /inventories.json
  def create
    @inventory = Inventory.new(inventory_params)

    respond_to do |format|
      if @inventory.save
        format.html { redirect_to inventory_url(@inventory), notice: "Inventory was successfully created." }
        format.json { render :show, status: :created, location: @inventory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventories/1 or /inventories/1.json
  def update
    respond_to do |format|
      if @inventory.update(inventory_params)
        format.html { redirect_to inventory_url(@inventory), notice: "Inventory was successfully updated." }
        format.json { render :show, status: :ok, location: @inventory }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventories/1 or /inventories/1.json
  def destroy
    @inventory.destroy

    respond_to do |format|
      format.html { redirect_to inventories_url, notice: "Inventory was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # ================
  def purchase_history
    @buyer_id = get_login_user.id
    @inventories = Inventory.where(user_id: @buyer_id)
  end

  def sale_history
    @seller_id = get_login_user.id
    @inventories = Array.new
    Inventory.all.each do |inventory|
      if Market.where(item_id: inventory.item_id).first.user_id == @seller_id
        @inventories.push(inventory)
      end
    end
  end

  def top_seller
    @filter = params[:filter]
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    if !@start_date.nil?
      @tmp_start_date = @start_date
      @start_date = DateTime.strptime(@start_date, "%m/%d/%Y")
    end
    if !@end_date.nil?
      @tmp_end_date = @end_date
      @end_date = DateTime.strptime(@end_date, "%m/%d/%Y")
    end

    if !@start_date.nil? && !@end_date.nil?
      @tmp_range_date = @tmp_start_date + ' - ' + @tmp_end_date
      @sellers = User.where(user_type: 1)
      @top_amount_seller = Hash.new
      @top_sale_seller = Hash.new
      @sellers.each do |seller|
        @seller_id = seller.id
        @top_amount_seller[@seller_id] = 0
        @top_sale_seller[@seller_id] = 0
      end
      @inventories = Inventory.all()
      @inventories.each do |inventory|
        if inventory.timestamp.between?(@start_date, @end_date)
          @seller_id = Market.where(item_id: inventory.item_id).first.user_id
          @top_amount_seller[@seller_id] += inventory.qty
          @top_sale_seller[@seller_id] += inventory.price
        end
      end
      @top_amount_seller = @top_amount_seller.sort_by {|k, v| v}.reverse
      @top_sale_seller = @top_sale_seller.sort_by {|k, v| v}.reverse
    end
  end

  def sort_top_seller
    @start_date = params[:daterange][0..9]
    @end_date = params[:daterange][13..]
    @filter = params[:filter]
    if @start_date.nil? || @end_date.nil?
      redirect_to top_seller_path, alert: "Please Select Date"
    elsif @filter.nil?
      redirect_to top_seller_path, alert: "Please Select Sort method (radio button)"
    else
      redirect_to top_seller_path + '/?filter=' + @filter + '&start_date=' + @start_date + '&end_date=' + @end_date
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory
      @inventory = Inventory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def inventory_params
      params.require(:inventory).permit(:user_id, :item_id, :price, :qty, :timestamp)
    end
end
