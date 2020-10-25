class AddressController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.valid?
      @address.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def address_params
    params.require(:address).permit(
      :postal_code,
      :prefecture_id,
      :municipality,
      :address,
      :building_name,
      :phone
    )
          .merge(user_id: current_user.id)
  end
end
