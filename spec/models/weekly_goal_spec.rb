require 'rails_helper'

RSpec.describe WeeklyGoal, type: :model do

  describe "バリデーション" do
    let(:weekly_goal) { FactoryBot.build(:weekly_goal) }
    it "週の目標が必須であること" do
      weekly_goal.goal = ""
      expect(weekly_goal).not_to be_valid
    end
    it "週の目標が24文字以内であること" do
      weekly_goal.goal = "a" * 25
      expect(weekly_goal).not_to be_valid
    end
  end
  
end
