require 'rails_helper'

RSpec.describe "ToDos", type: :request do
  let!(:current_user) { FactoryBot.build(:user) }
  let(:auth_tokens) { login(current_user) }
  let(:not_auth_tokens) { not_login }
  let(:weekly_goal) { current_user.weekly_goals.create(goal: "testWeeklyGoal") }

  before do
    #メール認証
    current_user.skip_confirmation!
    current_user.save
  end

  describe "POST /weekly_goals/:weekly_goal_id/to_dos #create" do
    context "ログイン済みのユーザーの場合" do
      it "ToDoの作成ができること" do
        expect(ToDo.count).to eq 0
        post weekly_goal_to_dos_path(weekly_goal), headers: auth_tokens, params: { todo: { goal: "todo Test" } }
        expect(ToDo.count).to eq 1
        expect(response.status).to eq 200
      end
    end
    context "未ログインのユーザーの場合" do
      it "ToDoの作成ができないこと" do
        expect(ToDo.count).to eq 0
        post weekly_goal_to_dos_path(weekly_goal), headers: not_auth_tokens, params: { todo: { goal: "todo Test" } }
        expect(ToDo.count).to eq 0
        expect(response.status).to eq 401
      end
    end
  end
  
  describe "DELETE /weekly_goals/:weekly_goal_id/to_dos/:id #destroy" do
    let!(:to_do) { weekly_goal.to_dos.create( goal: "todo Test" ) }
    context "ログイン済みのユーザーの場合" do
      it "ToDoが削除できること" do
        expect(ToDo.count).to eq 1
        delete weekly_goal_to_do_path(weekly_goal, to_do), headers: auth_tokens
        expect(ToDo.count).to eq 0
        expect(response.status).to eq 200
      end
    end
    context "未ログインのユーザーの場合" do
      it "ToDoが削除できないこと" do
        expect(ToDo.count).to eq 1
        delete weekly_goal_to_do_path(weekly_goal, to_do), headers: not_auth_tokens
        expect(ToDo.count).to eq 1
        expect(response.status).to eq 401
      end
    end
  end
end
