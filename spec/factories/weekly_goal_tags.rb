FactoryBot.define do
  factory :weekly_goal_tag do
    association :weekly_goal
    association :tag
  end
end
