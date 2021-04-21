class ItemsController < ApplicationController
  # before_action :find_item, except: [:index, :new, :create]
  # before_action :find_merchant

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @top_five_items = @merchant.items.top_five
    @enabled_items = @merchant.items.enabled_items
    @disabled_items = @merchant.items.disabled_items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    # require "pry"; binding.pry
    item = Item.find(params[:id])
    merchant_id = item.merchant_id
    @merchant = Merchant.find(merchant_id)
    item.update(item_params)
    # require "pry"; binding.pry
    if item.save #&& params[:item]
      flash[:notice] = "Item successfully updated!"
      redirect_to "/merchants/#{merchant_id}/items/#{item.id}"
    else
      redirect_to "/merchants/#{merchant_id}/items/"
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.new(item_params)

    if item.save
      redirect_to merchant_items_path(merchant)
    else
      flash[:notice] = "Error: Invalid Input. Complete all forms."
      redirect_to item_create_path(merchant)
    end
  end


  private

  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
  # def find_merchant
  #   @merchant = Merchant.find(params[:merchant_id])
  # end
  #
  # def find_item
  #   @item = Item.find(params[:id])
  # end
end
