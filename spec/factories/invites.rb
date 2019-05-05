FactoryBot.define do
  factory :invite do
    invitable { create(:quotation) }
    sender    { create(:user) }
    email     { Faker::Internet.email }

    after(:create) { |invite| invite.invitable.approved! }
  end
end
