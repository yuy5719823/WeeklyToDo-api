FactoryBot.define do
  factory :monthly_memo do
    association :monthly_goal, factory: :monthly_goal
    memo       { "Memo MonthlyGoal" }
  end
end
