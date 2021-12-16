require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { FactoryBot.build(:user) }

  describe 'ユーザー登録' do
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
end
