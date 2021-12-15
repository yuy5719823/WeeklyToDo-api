require 'rails_helper'
# include ActionController::RespondWith

RSpec.describe "MonthlyGoals", type: :request do
  let!(:current_user) { FactoryBot.build(:user) }
  let(:auth_tokens) { login(current_user) }
  let(:not_auth_tokens) { not_login }
  let(:goal) { "testMonthlyGoal" }

  before do
    #メール認証
    current_user.skip_confirmation!
    current_user.save
  end

  describe "GET /monthly_goals #index" do
    # subject { get monthly_goals_path }
    context "ログイン済みのユーザーの場合" do
      it "月の目標を取得できること" do
        get monthly_goals_path, headers: auth_tokens
        expect(response.status).to eq 200
      end
    end

    context "未ログインのユーザーの場合" do
      it "月の目標が取得できないこと" do
        get monthly_goals_path
        expect(response.status).to eq 401
      end
    end
  end

  describe "POST /monthly_goals #create" do
    context "ログイン済みのユーザーの場合" do
      it '月の目標が設定できること' do
        expect(MonthlyGoal.count).to eq 0
        post monthly_goals_path, headers: auth_tokens, params: { monthly_goal: { goal: goal } }
        expect(MonthlyGoal.count).to eq 1
        expect(response.status).to eq 200
      end
    end
    context "未ログインのユーザーの場合" do
      it "月の目標の設定ができないこと" do
        expect(MonthlyGoal.count).to eq 0
        post monthly_goals_path, headers: not_auth_tokens, params: { monthly_goal: { goal: goal } }
        expect(MonthlyGoal.count).to eq 0
        expect(response.status).to eq 401
      end
    end
  end

  describe "DELETE /monthly_goals/:id #destroy" do
    let!(:monthly_goal) { current_user.monthly_goals.create(goal: goal) }
    context "ログイン済みのユーザーの場合" do
      it "月の目標を削除することができる" do
        expect(MonthlyGoal.count).to eq 1
        delete monthly_goal_path(monthly_goal.id), headers: auth_tokens
        expect(MonthlyGoal.count).to eq 0
        expect(response.status).to eq 200
      end
    end
    context "未ログインのユーザーの場合" do
      it "月の目標を削除することができない" do
        expect(MonthlyGoal.count).to eq 1
        delete monthly_goal_path(monthly_goal.id), headers: not_auth_tokens
        expect(MonthlyGoal.count).to eq 1
        expect(response.status).to eq 401
      end
    end
  end

  describe "PATCH /monthly_goals/:id #update" do
    let!(:monthly_goal) { current_user.monthly_goals.create(goal: goal) }
    context "ログイン済みのユーザーの場合" do
      it "月の目標を変更することができる" do
        patch monthly_goal_path(monthly_goal.id), headers: auth_tokens, params: { monthly_goal: { goal: "edit Goal"}}
        expect(MonthlyGoal.last.goal).not_to eq monthly_goal.goal
        expect(response.status).to eq 200
      end
    end
    context "未ログインのユーザーの場合" do
      it "月の目標を変更することができない" do
        patch monthly_goal_path(monthly_goal.id), headers: not_auth_tokens, params: { monthly_goal: { goal: "edit Goal"}}
        expect(MonthlyGoal.last.goal).to eq monthly_goal.goal
        expect(response.status).to eq 401
      end
    end
  end

end
