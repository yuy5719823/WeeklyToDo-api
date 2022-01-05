require 'rails_helper'

RSpec.describe MonthlyGoal, type: :model do
  
  describe 'validations' do
    let(:monthly_goal) { FactoryBot.build( :monthly_goal ) }
    context "goal" do
      it '月の目標のタイトルが空文字は無効であること' do
        monthly_goal.goal = ""
        expect(monthly_goal).not_to be_valid
      end
      it '月の目標のタイトルが24文字以内であること' do
        monthly_goal.goal = "a" * 25
        expect(monthly_goal).not_to be_valid 
      end
    end
  end

  describe "associations" do
    it { should belong_to(:user)}
    it { should have_many(:monthly_memos) }
    context "月の目標 - メモ" do
      let!(:monthly_goal) { FactoryBot.create(:monthly_goal) }
      let!(:monthly_memo) { monthly_goal.monthly_memos.create(memo: "memo Test")}
      it "月の目標が削除されたらメモも削除されること" do
        expect{ monthly_goal.destroy }.to change{ MonthlyMemo.count }.by(-1)
      end
    end
  end

end
