class Transaction
  include ActiveModel::Model
  attr_accessor :token,
                :postal_code,
                :prefecture_id,
                :municipality,
                :address,
                :building_name,
                :phone,
                :order_id,
                :item_id,
                :user_id

  with_options presence: true do
    validates :token
    validates :postal_code,
              # ハイフンが必要であること（123-4567となる）
              format: { with: /\A[0-9]{3}-[0-9]{4}\z/, messsgge: 'is invalid' }
    validates :prefecture_id,
              numericality: { other_than: 1, message: 'Select' }
    validates :municipality, :address
    validates :phone,
              # ハイフンは不要で、11桁以内であること
              format: { with: /\A[0-9]{10,11}\z/, message: 'は「-」を入力しないでください' }
  end

  def save
    # カードの情報を保存
    Order.create(id: order_id, item_id: item_id, user_id: user_id)
    # 住所の情報を保存
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, address: address, building_name: building_name, order_id: order_id)
  end
end
