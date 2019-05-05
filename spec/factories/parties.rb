FactoryBot.define do
  factory :party do
    initialize_with do
      create(:invite).invitable.party
    end
  end
end
