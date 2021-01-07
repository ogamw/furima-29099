class Tag < ApplicationRecord

  has_many :tag_items
  has_many :items, through: :tag_items

end
