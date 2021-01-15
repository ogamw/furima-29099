class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_item, only: [:show, :destroy, :edit, :update]
  before_action :search_item, only: [:index, :show, :destroy, :edit, :search]
  def index
    @items = Item.all.order('created_at ASC')
    @items  = @q.result(distinct: true)
  end

  def new
    @item = TagsItem.new
  end

  def create
    @item = TagsItem.new(items_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def  show
    @tag_item = TagItem.find(params[:id])
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
    @item = TagsItem.new
   end
 
   def update
    @item = TagsItem.new(items_params)
     if @item.valid?
       @item.save
       redirect_to root_path
     else
       render :edit
     end
   end

  def search
    @tags_items = @q.result(distinct: true)
  end

  private

  def items_params
    params.require(:tags_item).permit(
      :item_name,
      :image,
      :text,
      :category_id,
      :condition_id,
      :postage_id,
      :shipping_area_id,
      :days_to_ship_id,
      :price,
      :tag_name
    )
          .merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def search_item
    @q = Item.ransack(params[:q])  # 検索オブジェクトを生成
    @category = Category.where.not(id: 1)  # この記述でid: 1を持ってるやつ以外を指定
    @condition = Condition.where.not(id: 1)
    @postage = Postage.where.not(id: 1)
    @shipping_area = ShippingArea.where.not(id: 1)
    @days_to_ship = DaysToShip.where.not(id: 1)
  end
end
