class MonthlyMemo < ApplicationRecord
  belongs_to :monthly_goal

  validates :memo, presence: true, length: { maximum: 140 }
end
