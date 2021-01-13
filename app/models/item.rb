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
  has_many :tag_items, foreign_key: :item_id, dependent: :destroy
  has_many :tags, through: :tag_items

end
