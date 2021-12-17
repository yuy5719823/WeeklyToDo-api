class WeeklyGoal < ApplicationRecord
  belongs_to :user

  validates :goal, presence: true, length: { maximum: 24 }
end
