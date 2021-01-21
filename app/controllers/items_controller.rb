class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_item, only: [:show, :destroy]
  before_action :search_item, only: [:index, :show, :destroy, :edit, :search]
  def index
    @items = Item.all.order('created_at ASC')
    @items  = @q.result(distinct: true)
  end

  def new
    @tags_item = TagsItem.new
  end

  def create
    @tags_item = TagsItem.new(items_params)
    if @tags_item.valid?
      @tags_item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def  show
    @item = Item.find(params[:id])
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
    @item = current_user.items.find(params[:id])

    @tegs_item = TagsItem.new(item: @item)
   end
 
   def update
    @item = current_user.items.find(params[:id])

    @tags_item = TagsItem.new(update_items_params, item: @item)
     if @tags_item.valid?
       @tags_item.save
       redirect_to root_path
     else
       render :edit
     end
   end

  def search
    @tags_items = @q.result(distinct: true)
  end

  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  private

  def items_params
    params.permit(
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

  def update_items_params
    params.require(:item).permit(
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
