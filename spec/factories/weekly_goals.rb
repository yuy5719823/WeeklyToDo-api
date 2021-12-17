FactoryBot.define do
  factory :weekly_goal do
    association :user, factory: :user
    goal        { "Test WeeklyGoal" }
  end
end
