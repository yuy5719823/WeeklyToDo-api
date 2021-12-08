require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { FactoryBot.build(:user) }

  describe 'ユーザー登録' do
    it "name、emailが存在、password、password_confirmationが一致すれば登録できること" do
      expect(user).to be_valid
    end
  end
end
