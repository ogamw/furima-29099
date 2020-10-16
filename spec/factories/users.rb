FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end

    nickname              { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 8) }
    password_confirmation { password}
    familyname            {person.last.kanji}
    firstname             {person.first.kanji}
    kana_familyname       {person.last.katakana}
    kana_firstname        {person.first.katakana}
    birthday              {Faker::Date.birthday}
  end
end
