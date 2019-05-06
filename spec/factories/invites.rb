FactoryBot.define do
  factory :invite do
    invitable { create(:quotation) }
    sender    { create(:user) }
    email     { Faker::Internet.email }

    after(:create) do |invite|
      invite.invitable.approved! if invite.invitable_type == 'Quotation'
    end
  end
end
