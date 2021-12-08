require 'rails_helper'

RSpec.describe MonthlyGoal, type: :model do
  
  describe 'バリデーション' do
    let(:monthly_goal) { FactoryBot.build( :monthly_goal ) }
    it '月の目標のタイトルが空文字は無効であること' do
      monthly_goal.goal = ""
      expect(monthly_goal).not_to be_valid
    end
    it '月の目標のタイトルが24文字以内であること' do
      monthly_goal.goal = "a" * 25
      expect(monthly_goal).not_to be_valid 
    end
  end
end
