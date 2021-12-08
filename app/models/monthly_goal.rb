class MonthlyGoal < ApplicationRecord
  belongs_to :user
  has_many :monthly_memos

  validates :goal, presence: true, length: { maximum: 24}
end
