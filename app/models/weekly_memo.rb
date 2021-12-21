class WeeklyMemo < ApplicationRecord
  belongs_to :weekly_goal

  validates :memo, presence: true, length: { maximum: 140 }
end
