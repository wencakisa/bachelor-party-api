FactoryBot.define do
  factory :party do
    transient do
      invite { create(:invite) }
    end

    initialize_with { invite.invitable.party }
  end
end
