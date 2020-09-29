FactoryBot.define do
  factory :item do
    item_name {Faker::Name.name}
    text {Faker::Lorem.sentence}
    price {Faker::Number.number}

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end

  end
end