require 'rails_helper'

RSpec.describe ToDo, type: :model do
  let(:to_do) { FactoryBot.build(:to_do) }
  describe "validations" do
    context "goal" do
      it "目標が必須であること" do
        to_do.goal = ""
        expect(to_do).not_to be_valid
      end
      it "目標が24文字以内であること" do
        to_do.goal = "a" * 25
        expect(to_do).not_to be_valid
      end
    end
    context "complete_flag" do
      it "boolean型のみ有効であること" do
        #文字列の代入、0以外はtrue
        to_do.complete_flag = nil
        expect(to_do).not_to be_valid
      end
    end
  end

  describe "init" do
    it "ToDoの完了フラグの初期値がfalseであること" do
      expect(to_do.complete_flag).to be_falsey
    end
  end

  describe "associations" do
    it { should belong_to(:weekly_goal) }
  end
  
end
