FactoryBot.define do
  factory :quotation do
    group_size { Faker::Number.between(1, 50) }
    user_email { Faker::Internet.email }
    date       { Faker::Date.forward }
    activities { create_list(:activity, 5) }
    prices     { activities.map(&:prices).map(&:first) }
  end
end
