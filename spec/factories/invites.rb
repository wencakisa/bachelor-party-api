FactoryBot.define do
  factory :invite do
    invitable { create(:quotation) }
    sender    { create(:user) }
    email     { Faker::Internet.email }
  end
end
