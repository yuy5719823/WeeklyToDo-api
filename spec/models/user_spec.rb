require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { FactoryBot.build(:user) }

  describe 'validation' do
    context "受け取ったユーザー情報が有効な場合" do
      it "name(24文字以内)、emailが存在、password、password_confirmationが一致すればユーザーの登録ができること" do
        expect(user).to be_valid
      end
    end

    context "受け取ったユーザー情報が有効でない場合" do
      it "nameが必要であること" do
        user.name = ""
        expect(user).not_to be_valid
      end
      it "nameが24文字以内であること" do
        user.name = "a"*25
        expect(user).not_to be_valid
      end
    end
  end

  describe "association" do
    let!(:user) { FactoryBot.create(:user) }
    context "ユーザー - 月の目標" do
      let!(:monthly_goal) { user.monthly_goals.create(goal: "goal Test") }
      it "ユーザーが削除されたら月の目標も削除されること" do
        expect{ user.destroy }.to change{ MonthlyGoal.count }.by(-1)
      end
    end
    context "ユーザー - 週の目標" do
      let!(:weekly_goal) { user.weekly_goals.create(goal: "goal Test") }
      it "ユーザーが削除されたら週の目標も削除されること" do
        expect{ user.destroy }.to change{ WeeklyGoal.count }.by(-1)
      end
    end
    context "ユーザー - タグ" do
      let!(:tag) { user.tags.create( tag_name: "tagTest") }
      it "ユーザーが削除されたらタグも削除されること" do
        expect{ user.destroy }.to change{ Tag.count }.by(-1)
      end
    end
  end

end
