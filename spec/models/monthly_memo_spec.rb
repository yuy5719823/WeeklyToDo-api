require 'rails_helper'

RSpec.describe MonthlyMemo, type: :model do
  describe 'validations' do
    let(:monthly_memo) { FactoryBot.build(:monthly_memo) }
    context "memo" do
      it 'メモの空文字は無効であること' do
        monthly_memo.memo = ""
        expect(monthly_memo).not_to be_valid
      end
      it 'メモが140文字以上は無効であること' do
        monthly_memo.memo = "a" * 141 
        expect(monthly_memo).not_to be_valid
      end
    end

    describe "associations" do
      it { should belong_to(:monthly_goal) }
    end
  end
end
