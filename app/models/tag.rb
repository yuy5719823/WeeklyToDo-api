class Tag < ApplicationRecord
  belongs_to :user
  has_many    :weekly_goal_tags
  has_many    :weekly_goals, through: :weekly_goal_tags

  validates :name, presence: true, length: { maximum: 12 }, uniqueness: { scope: :user }

end
