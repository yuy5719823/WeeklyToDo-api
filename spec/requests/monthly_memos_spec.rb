require 'rails_helper'

RSpec.describe "MonthlyMemos", type: :request do
  let!(:current_user) { FactoryBot.build(:user) }
  let(:auth_tokens) { login(current_user) }
  let(:not_auth_tokens) { not_login }
  let(:monthly_goal) { current_user.monthly_goals.create(goal: "testMonthlyGoal") }

  before do
    #メール認証
    current_user.skip_confirmation!
    current_user.save
  end

  describe "GET /monthly_goal_monthly_memos_path #create" do
    context "ログイン済みのユーザーの場合" do
      it "メモを追加できること" do
        expect(MonthlyMemo.count).to eq 0
        post monthly_goal_monthly_memos_path(monthly_goal), headers: auth_tokens, params: { monthly_memo: { memo: "testMemo"} }
        expect(MonthlyMemo.count).to eq 1
        expect(response.status).to eq 200
      end
    end

    context "未ログインのユーザーの場合" do
      it "メモを追加できないこと" do
        expect(MonthlyMemo.count).to eq 0
        post monthly_goal_monthly_memos_path(monthly_goal), headers: not_auth_tokens, params: { monthly_memo: { memo: "testMemo"} }
        expect(MonthlyMemo.count).to eq 0
        expect(response.status).to eq 401
      end
    end
  end

  describe "DELETE /monthly_goal_monthly_memo_path #destroy" do
    let!(:memo) { monthly_goal.monthly_memos.create( memo: "testMemo" ) }
    context "ログイン済みのユーザーの場合" do
      it "メモを削除できること" do
        expect(MonthlyMemo.count).to eq 1
        delete monthly_goal_monthly_memo_path(monthly_goal ,memo), headers: auth_tokens
        expect(MonthlyMemo.count).to eq 0
        expect(response.status).to eq 200
      end
    end
    context "未ログインのユーザーの場合" do
      it "メモを削除できないこと" do
        expect(MonthlyMemo.count).to eq 1
        delete monthly_goal_monthly_memo_path(monthly_goal ,memo), headers: not_auth_tokens
        expect(MonthlyMemo.count).to eq 1
        expect(response.status).to eq 401
      end
    end
  end
end
