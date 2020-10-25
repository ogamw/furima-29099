class Transaction

  include ActiveModel::Model
  attr_accessor :token,
                :postal_code,
                :prefecture,
                :municipality,
                :address,
                :building_name,
                :phone,
                :item_id,
                :user_id



  validates :token, presence: true

  with_options presence: true do
    validates :postal_code,
              #ハイフンが必要であること（123-4567となる）
              format: {with: /\A[0-9]{3}-[0-9]{4}\z/, messsgge: "は「-」も入力してください"}
    validates :prefecture, :municipality, :address
    validates :phone,
              #ハイフンは不要で、11桁以内であること
              format: {with: /\A[0-9]{10,11}\z/, message: "は「-」を入力しないでください"}
  end
  
  # with_options numericality: { other_than: 1, message: 'Select' } do
  #   validates :prefecture_id
  # end


  def save
    # 住所の情報を保存
    Address.create(postal_code: postal_code, prefecture: prefecture, municipality: municipality, address: address, building_name: building_name,user_id: user.id)
    # カードの情報を保存
    Oder.create(item_id: item_id, user_id: user_id)
  end
end
