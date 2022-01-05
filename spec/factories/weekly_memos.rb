FactoryBot.define do
  factory :weekly_memo do
    association :weekly_goal
    memo       { "Memo MonthlyGoal" }
  end
end
