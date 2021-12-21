require 'rails_helper'

RSpec.describe "WeeklyMemos", type: :request do
  let!(:current_user) { FactoryBot.build(:user) }
  let(:auth_tokens) { login(current_user) }
  let(:not_auth_tokens) { not_login }
  let(:weekly_goal) { current_user.weekly_goals.create(goal: "testWeeklyGoal") }

  before do
    #メール認証
    current_user.skip_confirmation!
    current_user.save
  end

  describe "CREATE /weekly_goals/:weekly_goal_id/weekly_memos #create" do
    context "ログイン済みのユーザーの場合" do
      it "メモを追加できること" do
        expect(WeeklyMemo.count).to eq 0
        post weekly_goal_weekly_memos_path(weekly_goal), headers: auth_tokens, params: { weekly_memo: { memo: "testMemo"} }
        expect(WeeklyMemo.count).to eq 1
      end
    end
    context "未ログインのユーザーの場合" do
      it "メモを追加できないこと" do
        expect(WeeklyMemo.count).to eq 0
        post weekly_goal_weekly_memos_path(weekly_goal), headers: not_auth_tokens, params: { weekly_memo: { memo: "testMemo"} }
        expect(WeeklyMemo.count).to eq 0
      end
    end
  end
end
