FactoryBot.define do
  factory :user, aliases: %i[host] do
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
