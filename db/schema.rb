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

ActiveRecord::Schema[7.0].define(version: 2022_06_01_081553) do
  create_table "subtasks", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.string "description"
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_subtasks_on_task_id"
  end

  create_table "tasks", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "description", null: false
    t.date "deadline", null: false
    t.boolean "completed"
    t.integer "user_id"
    t.integer "assignee_id", null: false
    t.boolean "public"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "display_name", default: "名無しさん", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "subtasks", "tasks"
end
