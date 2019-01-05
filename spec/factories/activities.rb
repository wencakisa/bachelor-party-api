FactoryBot.define do
  factory :activity do
    title     { Faker::App.unique.name }
    subtitle  { Faker::Company.catch_phrase }
    duration  { Faker::Number.between(1, 50) }
    time_type { :day }
    prices    { create_list(:price, 5) }
  end
end
