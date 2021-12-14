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
    context "ログイン済みの場合" do
      it "月の目標を取得できること" do
        get monthly_goals_path, headers: auth_tokens
        expect(response.status).to eq 200
      end
    end

    context "未ログインの場合" do
      it "月の目標が取得できないこと" do
        get monthly_goals_path
        expect(response.status).to eq 401
      end
    end
  end

  describe "POST /monthly_goals #create" do
    context "ログイン済みの場合" do
      it '月の目標が設定できること' do
        post monthly_goals_path, headers: auth_tokens, params: { monthly_goal: { goal: goal } }
        # expect(body["goal"]).to eq goal
        expect(response.status).to eq 200
      end
    end
    context "未ログインの場合" do
      it "月の目標の設定ができないこと" do
        post monthly_goals_path, headers: not_auth_tokens, params: { monthly_goal: { goal: goal } }
        expect(response.status).to eq 401
      end
    end
  end



end
