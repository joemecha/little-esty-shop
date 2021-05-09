FactoryBot.define do
  factory :item do
    name { Faker::Creature::Animal.name.upcase + " " + Faker::House.furniture }
    description { Faker::Hipster.sentence(word_count: 5) }
    unit_price { Faker::Number.number(digits: 4) }
    merchant
  end
end
