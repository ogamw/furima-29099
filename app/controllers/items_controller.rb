class ItemsController < ApplicationController
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

  private

  def items_params
    params.require(:items).permit(:content, :image, :text, :category_id, :condition_id,:postage_id, :shipping_area_id, :days_to_ship_id, :price).merge(user_id: current_user.id)
  end
end
