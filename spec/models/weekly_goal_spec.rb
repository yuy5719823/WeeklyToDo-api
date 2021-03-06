require 'rails_helper'

RSpec.describe WeeklyGoal, type: :model do

  describe "validations" do
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
  
  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:weekly_memos) }
    it { should have_many(:to_dos) }
    it { should have_one(:tag) }

    context "週の目標 - メモ" do
      let(:weekly_goal) { FactoryBot.create(:weekly_goal) }
      let!(:weekly_memo) { weekly_goal.weekly_memos.create(memo: "memo Test")}  
      it "週の目標が削除されたらメモも削除されること" do
        expect{ weekly_goal.destroy }.to change{ WeeklyMemo.count }.by(-1)
      end
    end
    context "週の目標 - ToDo" do
      let(:weekly_goal) { FactoryBot.create(:weekly_goal) }
      let!(:to_do) { weekly_goal.to_dos.create(goal: "toDo Test")}
      it "週の目標が削除されたらToDoも削除されること" do
        expect{ to_do.destroy }.to change{ ToDo.count }.by(-1)
      end
    end
    context "週の目標 - WeeklyGoalTag" do
      let(:user) { create(:user) }
      let(:weekly_goal) { user.weekly_goals.create(goal: "goalTest") }
      let(:tag) { user.tags.create(name: "testTag") }
      let!(:goal_tag) { create(:weekly_goal_tag, weekly_goal: weekly_goal, tag: tag) }
      it "週の目標が削除されたらタグの関連も削除されること" do
        expect{ goal_tag.destroy }.to change{ WeeklyGoalTag.count }.by(-1)
      end
    end
  end

end
