class WeeklyGoal < ApplicationRecord
  belongs_to :user
  has_many :weekly_memos, dependent: :destroy
  has_many :to_dos,       dependent: :destroy

  validates :goal, presence: true, length: { maximum: 24 }
end
