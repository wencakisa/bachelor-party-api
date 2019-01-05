FactoryBot.define do
  factory :price do
    amount { Faker::Number.non_zero_digit }
  end
end
