class WeeklyGoal < ApplicationRecord
  belongs_to :user
  has_many :weekly_memos, dependent: :destroy
  has_many :to_dos,       dependent: :destroy
  has_one :weekly_goal_tag, dependent: :destroy
  has_one :tag, through: :weekly_goal_tag

  validates :goal, presence: true, length: { maximum: 24 }
end
