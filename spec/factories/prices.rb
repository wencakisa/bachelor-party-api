FactoryBot.define do
  factory :price do
    amount { Faker::Commerce.price }
  end
end
