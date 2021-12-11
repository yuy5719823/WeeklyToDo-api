FactoryBot.define do
  factory :user do
    name                  { "testUser" }
    email                 { "test@example.com" }
    password              { "password" }
    password_confirmation { "password" }

    # trait :user_with_monthly_goals do
    #   after(:build) do | user |
    #     user.groups 
    #   end
    # end
  end
end
