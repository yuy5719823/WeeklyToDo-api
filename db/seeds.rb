# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#テストユーザーの作成
User.create(
  name: "testUser",
  email: "test@example.com",
  password: "password",
  password_confirmation: "password",
)

#テストデータの作成
user = User.find_by(email: "test@example.com")
3.times do | number |
  monthlyGoal = user.monthly_goals.create( goal: "testGoal_#{number}" )
  2.times do | number |
    monthlyGoal.monthly_memos.create( memo: "testMemo_#{number}" )
  end
end

puts "テストデータの作成完了"
