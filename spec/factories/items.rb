FactoryBot.define do
  factory :item do
    item_name {Faker::Name.name}
    text {Faker::Lorem.sentence}
    price {300} 
    category_id {2}
    condition_id{2}
    postage_id {2}
    shipping_area_id {2}
    days_to_ship_id {2}
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
    association :user
  end
end