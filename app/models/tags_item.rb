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

  # itemがすでに保存されているものか、新規のものかで、PUTとPATCHを分ける
  delegate :persisted?, to: :item

  def initialize(attributes = nil, item: Item.new)
    @item = item
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    return if invalid?

    ActiveRecord::Base.transaction do
      # mapメソッドを使いsplit_tag_namesをtagの情報に変換
      tags = split_tag_names.map { |tag_name| Tag.find_or_create_by!(tag_name: tag_name) }
      item.update!(image: image, item_name: item_name, text: text, price: price, category_id: category_id, condition_id: condition_id, postage_id: postage_id, shipping_area_id: shipping_area_id, days_to_ship_id: days_to_ship_id, user_id: user_id, tags: tags)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  # def save
  #   item = Item.create(image: image, item_name: item_name, text: text, price: price, category_id: category_id, condition_id: condition_id, postage_id: postage_id, shipping_area_id: shipping_area_id, days_to_ship_id: days_to_ship_id, user_id: user_id)
  #   tag = Tag.where(tag_name: tag_name).first_or_initialize  #  itemがすでに保存されているものか、新規のものかで、PUTとPATCHを分けている?
  #   tag.save

  #   TagItem.create(item_id: item.id, tag_id: tag.id)  #  TagItem と TagsItem は別なので注意
  # end

  #  formを飛ばす場所を（#createか#updateか）を判別して、切り替えている
  def to_model
    item
  end

  private

  attr_reader :item

  def default_attributes
    {
      image: item.image,
      item_name: item.item_name,
      text: item.text,
      price: item.price,
      category_id: item.category_id,
      condition_id: item.condition_id,
      postage_id: item.postage_id,
      shipping_area_id: item.shipping_area_id,
      days_to_ship_id: item.days_to_ship_id,
      user_id: item.user_id,
      tag_name: item.tags.pluck(:tag_name).join(',')
    }
  end

  def split_tag_names
    tag_name.split(',')
  end
end