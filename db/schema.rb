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

ActiveRecord::Schema.define(version: 2022_03_03_094825) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ad_logs", force: :cascade do |t|
    t.integer "from"
    t.integer "to"
    t.integer "by_user_id"
    t.string "reason"
    t.bigint "ad_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ad_id", "created_at"], name: "index_ad_logs_on_ad_id_and_created_at"
    t.index ["ad_id"], name: "index_ad_logs_on_ad_id"
  end

  create_table "ads", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.integer "status"
    t.string "pictures", default: [], array: true
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reason"
    t.index ["user_id", "created_at"], name: "index_ads_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_ads_on_user_id"
  end

  create_table "ads_tags", id: false, force: :cascade do |t|
    t.bigint "ad_id", null: false
    t.bigint "tag_id", null: false
    t.index ["ad_id", "tag_id"], name: "index_ads_tags_on_ad_id_and_tag_id", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated"
    t.datetime "activated_at", precision: 6
    t.string "reset_digest"
    t.datetime "reset_sent_at", precision: 6
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "ad_logs", "ads"
  add_foreign_key "ads", "users"
end
