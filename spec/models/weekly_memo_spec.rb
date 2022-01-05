require 'rails_helper'

RSpec.describe WeeklyMemo, type: :model do

  describe "validation" do
    let(:weekly_memo) { FactoryBot.build(:weekly_memo) }
    it "メモの空白は無効であること" do
      weekly_memo.memo = ""
      expect(weekly_memo).not_to be_valid
    end
    it 'メモが140文字以上は無効であること' do
      weekly_memo.memo = "a" * 141 
      expect(weekly_memo).not_to be_valid
    end  end
end
