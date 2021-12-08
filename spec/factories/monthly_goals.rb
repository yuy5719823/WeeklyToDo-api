FactoryBot.define do
  factory :monthly_goal do
    association :user, factory: :user
    goal        { "Test MonthlyGooal" }
  end
end
