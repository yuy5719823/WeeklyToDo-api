FactoryBot.define do
  factory :to_do do
    association :weekly_goal
    goal          { "toDo" }
    # complete_flag { false }
  end
end
