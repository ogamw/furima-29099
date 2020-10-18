class Address < ApplicationRecord
  belongs_to :order
  with_options presence: true do
    validates :postal_code,
              #ハイフンが必要であること（123-4567となる）
              format: {with: /\A[0-9]{3}-[0-9]{4}\z/, messsgge: "は「-」も入力してください"},
    validates :prefectures, :municipality, :address,
    validates :phone,
              #ハイフンは不要で、11桁以内であること
              format: {with: /\A[0-9]{11}\z/, message: "は「-」を入力しないでください"}
  end
  with_options numericality: { other_than: 1, message: 'Select' } do
    validates :prefectures_id
  end

end
