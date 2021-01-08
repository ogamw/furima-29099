class TagsItem
  include ActiveModel::Model
  attr_accessor :image,
                :Item_name,
                :text,
                :price,
                :category,
                :condition,
                :postage,
                :shipping_area,
                :days_to_ship,
                :tag_name

  with_options presence: true do
    validates :image, :item_name, :text, :price, :category, :condition, :postage, :shipping_area, :days_to_ship, :tag_name
  end
  with_options numericality: { other_than: 1, message: 'Select' } do
    validates :category_id, :condition_id, :postage_id, :shipping_area_id, :days_to_ship_id
  end
  validates :price, numericality: { greater_than: 299, less_than: 10_000_000, message: 'Out of setting range' }


  def save
    item = Item.create(image: image, item_name: item_name, text: text, price: price, category: category, condition: condition, postage: postage, shipping_area: shipping_area, days_to_ship: days_to_ship)
    tag = Tag.create(tag_name: tag_name)

    TagItem.create(item_id: item.id, tag_id: tag.id)
  end

end