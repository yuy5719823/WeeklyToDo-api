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

  describe "POST /weekly_goals/:weekly_goal_id/weekly_memos #create" do
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

  describe "DELETE	/weekly_goals/:weekly_goal_id/weekly_memos/:id #destroy" do
    let!(:weekly_memo) { weekly_goal.weekly_memos.create( memo: "testMemo" ) }
    context "ログイン済みユーザーの場合" do
      it "メモの削除ができること" do
        expect(WeeklyMemo.count).to eq 1
        delete weekly_goal_weekly_memo_path(weekly_goal, weekly_memo), headers: auth_tokens
        expect(WeeklyMemo.count).to eq 0
      end
    end
    context "未ログインのユーザーの場合" do 
      it "メモの削除ができないこと" do
        expect(WeeklyMemo.count).to eq 1
        delete weekly_goal_weekly_memo_path(weekly_goal, weekly_memo), headers: not_auth_tokens
        expect(WeeklyMemo.count).to eq 1
      end
    end
  end

  describe "PATCH	/weekly_goals/:weekly_goal_id/weekly_memos/:id #update" do
    let!(:weekly_memo) { weekly_goal.weekly_memos.create( memo: "testMemo" ) }
    context "ログイン済みのユーザーの場合" do
      it "メモの編集ができること" do
        patch weekly_goal_weekly_memo_path(weekly_goal, weekly_memo), headers: auth_tokens, params: { weekly_memo: { memo: "update Memo" } }
        expect(WeeklyMemo.last.memo).not_to eq weekly_memo.memo
      end
    end
    context "未ログインのユーザーの場合" do
      it "メモの編集ができないこと" do
        patch weekly_goal_weekly_memo_path(weekly_goal, weekly_memo), headers: not_auth_tokens, params: { weekly_memo: { memo: "update Memo" } }
        expect(WeeklyMemo.last.memo).to eq weekly_memo.memo
      end
    end
  end
end
