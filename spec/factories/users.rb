FactoryBot.define do
  factory :user do
    email    { Faker::Internet.email }
    password { Faker::Internet.password }

    factory :admin do
      role { :admin }
    end

    factory :guide do
      role { :guide }
    end
  end
end
