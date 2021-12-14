FactoryBot.define do
  factory :user do
    name                  { "testUser" }
    email                 { "test@example.com" }
    password              { "password" }
    password_confirmation { "password" }

    factory :client, class: 'user' do
      name                  { "client" }
      email                 { "client@example.com" }
      password              { "password" }
      password_confirmation { "password" }
    end

    # trait :user_with_monthly_goals do
    #   after(:build) do | user |
    #     user.groups 
    #   end
    # end
  end
end
