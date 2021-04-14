FactoryBot.define do
  factory :merchant, class: Merchant do
    name { Faker::Name }
  end
end
