class WeeklyGoalTag < ApplicationRecord
  belongs_to :weekly_goal
  belongs_to :tag

  validates :weekly_goal_id, uniqueness: { scope: :tag_id }
end
