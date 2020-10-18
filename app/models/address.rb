class Address < ApplicationRecord
  belongs_to :order
  with_options presence: true do
    validates :postal_code, :prefectures, :municipality, :address, :phone
  end
  with_options numericality: { other_than: 1, message: 'Select' } do
    validates :prefectures_id
  end

end
