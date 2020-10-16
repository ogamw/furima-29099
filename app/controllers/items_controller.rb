class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_item, only: [:destroy, :edit, :update, :show]
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
    if current_user.id == @item.user_id
      @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def edit
  end

  def update
    item.update(items_params)
  end

  def show
  end

  private

  def items_params
    params.require(:item).permit(:item_name, :image, :text, :category_id, :condition_id, :postage_id, :shipping_area_id, :days_to_ship_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
