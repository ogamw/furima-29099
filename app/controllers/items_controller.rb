class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @items = Item.all.order('created_at ASC')
  end

  def new
    @items = Item.new
  end

  def create
    @items = Item.new(items_params)
    if @items.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @items = Item.find(params[:id])
    if @items.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def edit
    @items = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(items_params)
  end

  def show
    @items = Item.find(params[:id])
  end

  private

  def items_params
    params.require(:item).permit(:item_name, :image, :text, :category_id, :condition_id, :postage_id, :shipping_area_id, :days_to_ship_id, :price).merge(user_id: current_user.id)
  end
end
