# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#テストユーザーの作成
user = User.new(
  name: "testUser",
  email: "test@example.com",
  password: "password",
  password_confirmation: "password",
)
#メール認証をスキップ
user.skip_confirmation!
user.save

#テストデータの作成
#月の目標、メモを作成
3.times do | number |
  monthlyGoal = user.monthly_goals.create( goal: "testMonthlyGoal_#{number}" )
  2.times do | number |
    monthlyGoal.monthly_memos.create( memo: "testMonthlyMemo_#{number}" )
  end
end

#タグを作成
2.times do | number | 
  user.tags.create( name: "tag_#{number}" )
end
#週の目標を作成
3.times do | number |
  weekly_goal = user.weekly_goals.create( goal: "testWeeklyGoal_#{number}")
  2.times do | number |
    weekly_goal.weekly_memos.create( memo: "testWeeklyMemo_#{number}")
  end
  #ToDoを作成
  3.times do | number |
    weekly_goal.to_dos.create( goal: "toDo_#{number}" )
  end
  #週の目標にタグを付与
  WeeklyGoalTag.create(weekly_goal: weekly_goal, tag: Tag.first )
end

puts "テストデータの作成完了"
