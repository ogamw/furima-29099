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
      :prefecture_id,
      :municipality,
      :address,
      :building_name,
      :phone
    )
    .merge(item_id: params[:item_id], user_id: current_user.id)
    # item_idは
    # params.permit(
    #   :item_id
    # )
    # .merge()でも可
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'          # 通貨の種類（日本円）
    )
  end
end
