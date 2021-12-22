# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_22_081718) do

  create_table "monthly_goals", force: :cascade do |t|
    t.integer "user_id"
    t.string "goal", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_monthly_goals_on_user_id"
  end

  create_table "monthly_memos", force: :cascade do |t|
    t.integer "monthly_goal_id"
    t.string "memo", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["monthly_goal_id"], name: "index_monthly_memos_on_monthly_goal_id"
  end

  create_table "to_dos", force: :cascade do |t|
    t.integer "weekly_goal_id"
    t.string "goal", null: false
    t.boolean "complete_flag", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["weekly_goal_id"], name: "index_to_dos_on_weekly_goal_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "weekly_goals", force: :cascade do |t|
    t.integer "user_id"
    t.string "goal", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_weekly_goals_on_user_id"
  end

  create_table "weekly_memos", force: :cascade do |t|
    t.integer "weekly_goal_id"
    t.string "memo", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["weekly_goal_id"], name: "index_weekly_memos_on_weekly_goal_id"
  end

  add_foreign_key "monthly_goals", "users"
  add_foreign_key "monthly_memos", "monthly_goals"
  add_foreign_key "to_dos", "weekly_goals"
  add_foreign_key "weekly_goals", "users"
  add_foreign_key "weekly_memos", "weekly_goals"
end
