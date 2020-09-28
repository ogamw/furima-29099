class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category, :condition, :postage, :shipping_area, :days_to_ship
  has_one_attached :image

  with_options presence: true do
    validates :item_name,:text,:price
  end
  with_options numericality: { other_than: 1 } do
    validates :category_id,:condition_id,:postage_id,:shipping_area_id,:days_to_ship_id
  end
end
