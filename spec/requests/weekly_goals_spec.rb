require 'rails_helper'

RSpec.describe "WeeklyGoals", type: :request do
  let!(:current_user) { FactoryBot.build(:user) }
  let(:auth_tokens) { login(current_user) }
  let(:not_auth_tokens) { not_login }
  let(:goal) { "testWeeklyGoal" }

  before do
    #メール認証
    current_user.skip_confirmation!
    current_user.save
  end


  describe "GET /weekly_goals #index" do
    context "ログイン済みのユーザーの場合" do
      it "週の目標を取得できること" do
        get weekly_goals_path, headers: auth_tokens
        expect(response.status).to eq 200
      end
    end
    context "未ログインのユーザーの場合" do
      it "週の目標を取得できないこと" do
        get weekly_goals_path, headers: not_auth_tokens
        expect(response.status).to eq 401
      end
    end
  end

  describe "POST 	/weekly_goals #create" do
    context "ログイン済みのユーザーの場合" do
      it "週の目標を設定できること" do
        expect(WeeklyGoal.count).to eq 0
        post weekly_goals_path, headers: auth_tokens, params: { weekly_goal: { goal: goal } }
        expect(response.status).to eq 200
        expect(WeeklyGoal.count).to eq 1
      end
    end
    context "未ログインのユーザーの場合" do
      it "週の目標を設定できないこと" do
        expect(WeeklyGoal.count).to eq 0
        post weekly_goals_path, headers: not_auth_tokens, params: { weekly_goal: { goal: goal } }
        expect(response.status).to eq 401
        expect(WeeklyGoal.count).to eq 0
      end
    end
  end
  
  describe "DELETE /weekly_goals/:id #destroy" do
    let!(:weekly_goal) { current_user.weekly_goals.create( goal: goal)}
    context "ログイン済みのユーザーの場合" do
      it "週の目標を削除できること" do
        expect(WeeklyGoal.count).to eq 1
        delete weekly_goal_path(weekly_goal), headers: auth_tokens
        expect(response.status).to eq 200
        expect(WeeklyGoal.count).to eq 0
      end
    end
    context "未ログインのユーザーの場合" do
      it "週の目標を削除できないこと" do
        expect(WeeklyGoal.count).to eq 1
        delete weekly_goal_path(weekly_goal), headers: not_auth_tokens
        expect(response.status).to eq 401
        expect(WeeklyGoal.count).to eq 1
      end
    end
  end

  describe "PATCH /weekly_goals/:id #update" do
    let!(:weekly_goal) { current_user.weekly_goals.create( goal: goal)}
    context "ログイン済みのユーザーの場合" do
      it "週の目標を更新できること" do
        patch weekly_goal_path(weekly_goal), headers: auth_tokens, params: { weekly_goal: { goal: "edit Goal"} }
        expect(response.status).to eq 200
        expect(WeeklyGoal.last.goal).not_to eq weekly_goal.goal
      end
    end
    context "未ログインのユーザーの場合" do
      it "週の目標を更新できないこと" do
        patch weekly_goal_path(weekly_goal), headers: not_auth_tokens, params: { weekly_goal: { goal: "edit Goal"} }
        expect(response.status).to eq 401
        expect(WeeklyGoal.last.goal).to eq weekly_goal.goal
      end
    end
    
  end
end
