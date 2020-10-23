class OrdersController < ApplicationController
  def index
    @order = Transactions.new
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
      :price,
      :token,
      :number,
      :exp_month,
      :exp_year,
      :cvc,
      :postal_code,
      :prefecture,
      :municipality,
      :address,
      :building_name,
      :phone
    )
    .merge(token: params[:token], user_id: current_user.id)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: params[:price],  # 商品の値段
      card: params[:token],    # カードトークン
      currency: 'jpy'          # 通貨の種類（日本円）
    )
  end
end
