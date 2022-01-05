FactoryBot.define do
  factory :monthly_goal do
    association :user
    goal        { "Test MonthlyGooal" }
  end
end
