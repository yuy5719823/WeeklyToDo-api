require 'rails_helper'

RSpec.describe Tag, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:user_tag) { user.tags.create(tag_name: tag.tag_name) }
  let(:tag) { user.tags.build(tag_name: "tagTest") }

  describe "validations" do
    context "tag_name" do
      it "タグ名の空文字は無効であること" do
        tag.tag_name = ""
        expect(tag).not_to be_valid
      end
      it "タグ名は12文字以下であること" do
        tag.tag_name = "a" * 13
        expect(tag).not_to be_valid
      end
      it "ユーザーごとにタグ名は一意であること" do
        expect(tag).not_to be_valid
      end
    end
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:weekly_goals) }
  end

end
