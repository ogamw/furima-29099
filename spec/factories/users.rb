FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 8)
    password {password}
    password_confirmation {password}
    familyname {Faker::Name.name('ja_JP')}
    firstname {Faker::Name.name('ja_JP')}
    kana_familyname {Faker::Name.name('ja_JP')}
    kana_firstname {Faker::Name.name('ja_JP')}
    birthday {Faker::Date.birthday}
  end
end

