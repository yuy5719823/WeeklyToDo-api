FactoryBot.define do
  factory :monthly_memo do
    association :monthly_goal
    memo       { "Memo MonthlyGoal" }
  end
end
