class CreateWeeklyGoalTags < ActiveRecord::Migration[6.1]
  def change
    create_table :weekly_goal_tags do |t|

      t.references :weekly_goal, null: false
      t.references :tag, null: false#, foreign_key: true

      t.timestamps
    end
    #組み合わせを一意に
    add_index :weekly_goal_tags, [:weekly_goal_id, :tag_id], unique: true
  end
end
