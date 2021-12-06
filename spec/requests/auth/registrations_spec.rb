require 'rails_helper'

RSpec.describe "Auth::Registrations", type: :request do
  # ユーザーの登録
  # POST auth/registrations#create
  # テストパターン
  #   ユーザー未登録
  #     有効なパラメータ、パラメータなし、無効なパラメータ
  #   ユーザー登録済み
  #     ログイン中のユーザーが登録、!!!退会済みのユーザーが登録(deviseはデフォルトで物理削除)
  
  describe "POST /auth #create " do
    context 'ユーザー未登録の場合' do
      let(:user) { FactoryBot.build(:user) }
      let(:user_attributes) { FactoryBot.attributes_for(:user) }
      it 'ユーザーの登録ができること(有効なパラメータ)' do
        expect(user).to be_valid
      end
      it 'ユーザーの登録ができないこと(パラメータなし)' do
        user.name = user.email = user.password = user.password_confirmation = ""
        expect(user).not_to be_valid
      end
      it 'ユーザーの登録ができないこと(パスワードの不一致)' do
        user.password = "hogehoge"
        expect(user).not_to be_valid
      end
    end
    context 'ユーザー登録済みの場合'  do
      let(:user) { FactoryBot.create(:user) }
      let(:user_dup) { user.dup }
      it 'ユーザーの登録ができないこと(登録済み)' do
        expect(user_dup).not_to be_valid
      end
    end
  end
end
