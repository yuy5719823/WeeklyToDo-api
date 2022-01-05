FactoryBot.define do
  factory :tag do
    association :user
    name  { "tagTest" }
  end
end
