class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_item, only: [:destroy, :edit, :update, :show]
  def index
    @items = Item.all.order('created_at ASC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(items_params)
    if @item.save
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

  def update
    if @item.update(items_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def search
    @items = Item.search(params[:keyword])
  end

  private

  def items_params
    params.require(:item).permit(
      :item_name,
      :image,
      :text,
      :category_id,
      :condition_id,
      :postage_id,
      :shipping_area_id,
      :days_to_ship_id,
      :price
    )
          .merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
