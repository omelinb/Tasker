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

ActiveRecord::Schema[7.0].define(version: 2022_07_13_012001) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "status", ["new", "in_progress", "completed", "canceled"]

  create_table "approvals", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "task_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_approvals_on_task_id"
    t.index ["user_id", "task_id"], name: "index_approvals_on_user_id_and_task_id", unique: true
    t.index ["user_id"], name: "index_approvals_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "creator_id", null: false
    t.string "title", null: false
    t.integer "approvals_count", default: 0, null: false
    t.enum "status", default: "new", null: false, enum_type: "status"
    t.datetime "deadline_at"
    t.datetime "completed_at"
    t.datetime "canceled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_tasks_on_creator_id"
    t.index ["title"], name: "index_tasks_on_title"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "approvals", "tasks"
  add_foreign_key "approvals", "users"
  add_foreign_key "tasks", "users", column: "creator_id"
end
