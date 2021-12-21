FactoryBot.define do
  factory :weekly_memo do
    association :weekly_goal, factory: :weekly_goal
    memo       { "Memo MonthlyGoal" }
  end
end
