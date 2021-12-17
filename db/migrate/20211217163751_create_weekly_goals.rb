class CreateWeeklyGoals < ActiveRecord::Migration[6.1]
  def change
    create_table :weekly_goals do |t|

      t.references :user, foreign_key: true
      t.string :goal, null: false

      t.timestamps
    end
  end
end
