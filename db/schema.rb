# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_05_31_080050) do

  create_table "activities", force: :cascade do |t|
    t.string "title"
    t.string "subtitle"
    t.string "details"
    t.boolean "transfer_included"
    t.boolean "guide_included"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.integer "time_type"
  end

  create_table "activities_quotations", id: false, force: :cascade do |t|
    t.integer "activity_id", null: false
    t.integer "quotation_id", null: false
    t.index ["activity_id", "quotation_id"], name: "index_activities_quotations_on_activity_id_and_quotation_id"
    t.index ["activity_id"], name: "index_activities_quotations_on_activity_id"
    t.index ["quotation_id", "activity_id"], name: "index_activities_quotations_on_quotation_id_and_activity_id", unique: true
  end

  create_table "invites", force: :cascade do |t|
    t.string "invitable_type"
    t.integer "invitable_id"
    t.string "token"
    t.string "email"
    t.integer "status", default: 0
    t.integer "sender_id"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invitable_type", "invitable_id"], name: "index_invites_on_invitable_type_and_invitable_id"
  end

  create_table "parties", force: :cascade do |t|
    t.string "title"
    t.integer "quotation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "guide_id"
    t.integer "host_id"
    t.string "last_guide_email"
    t.index ["guide_id"], name: "index_parties_on_guide_id"
    t.index ["host_id"], name: "index_parties_on_host_id"
    t.index ["quotation_id"], name: "index_parties_on_quotation_id"
  end

  create_table "prices", force: :cascade do |t|
    t.float "amount"
    t.string "options"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "activity_id"
    t.index ["activity_id"], name: "index_prices_on_activity_id"
  end

  create_table "prices_quotations", id: false, force: :cascade do |t|
    t.integer "quotation_id", null: false
    t.integer "price_id", null: false
    t.index ["quotation_id", "price_id"], name: "index_prices_quotations_on_quotation_id_and_price_id"
  end

  create_table "quotations", force: :cascade do |t|
    t.integer "status", default: 0
    t.integer "group_size"
    t.string "user_email"
    t.text "custom_email_message"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_parties", force: :cascade do |t|
    t.integer "user_id"
    t.integer "party_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["party_id"], name: "index_user_parties_on_party_id"
    t.index ["user_id"], name: "index_user_parties_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 2
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

end
