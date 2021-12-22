class ToDo < ApplicationRecord
  belongs_to :weekly_goal

  validates :goal,          presence: true, length: { maximum: 24 }
  validates :complete_flag, inclusion: { in: [true, false] }

  #ToDoが完了済みか
  def complete?
    flag = self.complete_flag
    return true if flag == true
    flag
  end
end
