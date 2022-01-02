FactoryBot.define do
  factory :tag do
    association :user
    tag_name  { "tagTest" }
  end
end
