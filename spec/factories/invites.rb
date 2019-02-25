FactoryBot.define do
  factory :invite do
    invitable { nil }
    token { "MyString" }
    status { false }
  end
end
