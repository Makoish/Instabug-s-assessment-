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

ActiveRecord::Schema[8.0].define(version: 2025_01_19_232556) do
  create_table "applications", force: :cascade do |t|
    t.string "token"
    t.string "application_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "chats_count"
    t.index ["token"], name: "index_applications_on_token", unique: true
  end

  create_table "arask_jobs", force: :cascade do |t|
    t.string "job"
    t.datetime "execute_at"
    t.string "interval"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["execute_at"], name: "index_arask_jobs_on_execute_at"
  end

  create_table "chats", force: :cascade do |t|
    t.integer "chat_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "messages_count"
    t.string "token_fk", null: false
    t.index ["token_fk", "chat_number"], name: "index_chats_on_token_fk_and_chat_number", unique: true
    t.index ["token_fk"], name: "index_chats_on_token_fk"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "message_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "payload"
    t.string "token_fk", null: false
    t.integer "chat_number_fk", null: false
    t.index ["chat_number_fk"], name: "index_messages_on_chat_number"
    t.index ["token_fk", "chat_number_fk", "message_number"], name: "index_messages_on_token_fk_chat_number_fk_and_message_number", unique: true
  end

  add_foreign_key "chats", "applications", column: "token_fk", primary_key: "token", on_delete: :cascade
  add_foreign_key "messages", "applications", column: "token_fk", primary_key: "token", on_delete: :cascade
  add_foreign_key "messages", "chats", column: "chat_number_fk", on_delete: :cascade
end
