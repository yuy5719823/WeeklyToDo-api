require 'rails_helper'

RSpec.describe WeeklyGoalTag, type: :model do
  let!(:user) { create(:user) }
  let(:weekly_goal) { user.weekly_goals.create(goal: "weeklyGoalTest") }
  let(:tag) { user.tags.create(tag_name: "tagTest") }
  let(:goal_tag) { build(:weekly_goal_tag, weekly_goal: weekly_goal, tag: tag) }

  describe "validations" do
    it "weekly_goalのidとtagのidの組み合わせが一意であること" do
      create(:weekly_goal_tag, weekly_goal: weekly_goal, tag: tag)
      expect(goal_tag).not_to be_valid
    end
  end

  describe "associations" do
    it { should belong_to(:weekly_goal) }
    it { should belong_to(:tag) }
  end
end
