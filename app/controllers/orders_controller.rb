class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item
  def index
    if (current_user.id != @item.user_id) && @item.purchaser_id.nil?
      @transaction = Transaction.new
    else
      redirect_to root_path
    end
  end

  def create
    @transaction = Transaction.new(order_params)
    if @transaction.valid?
      pay_item
      @transaction.save
      @item.purchaser_id = current_user.id
      @item.save
      binding.pry
      redirect_to root_path
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
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy'          # 通貨の種類（日本円）
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
