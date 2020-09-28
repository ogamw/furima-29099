class ItemsController < ApplicationController
  def index
    @items = Item.all.order('created_at ASC')
  end

  def new
    @items = Item.new
  end

  private

  def items_params
    params.require(:items).permit(:content, :image).merge(user_id: current_user.id)
  end
end
