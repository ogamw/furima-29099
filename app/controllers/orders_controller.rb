class OrdersController < ApplicationController
  def index
    @order = Transaction.new
    @item = Item.find(params[:item_id])
  end

  def create
    @order = Transaction.new(order_params)
    @item = Item.find(params[:item_id])
    if @order.valid?
      pay_item
      @order.save
      return redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.permit(
      :token,
      :postal_code,
      :prefecture,
      :municipality,
      :address,
      :building_name,
      :phone
    )
    .merge(item_id: params[:item_id], user_id: current_user.id)
    # .merge(item_id: current_user.item_ids, user_id: current_user.id)
    # .merge(token: params[:token], user_id: current_user.id)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: order_params[:price],  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'          # 通貨の種類（日本円）
    )
  end
end
