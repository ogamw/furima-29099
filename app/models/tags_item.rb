class TagsItem
  include ActiveModel::Model
  attr_accessor :image,
                :item_name,
                :text,
                :price,
                :category_id,
                :condition_id,
                :postage_id,
                :shipping_area_id,
                :days_to_ship_id,
                :tag_name,
                :user_id

  with_options presence: true do
    validates :image, :item_name, :text, :price, :category_id, :condition_id, :postage_id, :shipping_area_id, :days_to_ship_id
  end
  with_options numericality: { other_than: 1, message: 'Select' } do
    validates :category_id, :condition_id, :postage_id, :shipping_area_id, :days_to_ship_id
  end
  validates :price, numericality: { greater_than: 299, less_than: 10_000_000, message: 'Out of setting range' }


  def save
    item = Item.create(image: image, item_name: item_name, text: text, price: price, category_id: category_id, condition_id: condition_id, postage_id: postage_id, shipping_area_id: shipping_area_id, days_to_ship_id: days_to_ship_id, user_id: user_id)
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save

    TagItem.create(item_id: item.id, tag_id: tag.id)
  end

end