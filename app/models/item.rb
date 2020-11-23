class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :shipping_area
  belongs_to_active_hash :days_to_ship
  has_one_attached :image
  belongs_to :user
  has_one :order

  def self.search(search)
    if search != ""
      Item.where('text LIKE(?)', "%#{search}%")
    else
      Item.all
    end
  end

  with_options presence: true do
    validates :image, :item_name, :text, :category, :condition, :postage, :shipping_area, :days_to_ship, :price
  end
  with_options numericality: { other_than: 1, message: 'Select' } do
    validates :category_id, :condition_id, :postage_id, :shipping_area_id, :days_to_ship_id
  end
  validates :price, numericality: { greater_than: 299, less_than: 10_000_000, message: 'Out of setting range' }
end
