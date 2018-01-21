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

ActiveRecord::Schema.define(version: 20180121195315) do

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "name_long"
    t.boolean "is_service"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.boolean "is_root"
    t.boolean "is_client"
  end

  create_table "accounts_roles", id: false, force: :cascade do |t|
    t.integer "account_id"
    t.integer "role_id"
    t.index ["account_id", "role_id"], name: "index_accounts_roles_on_account_id_and_role_id", unique: true
  end

  create_table "brigades", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "counts", force: :cascade do |t|
    t.integer "price_id"
    t.decimal "quantity", precision: 8, scale: 2
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ticket_id"
    t.decimal "price_on_init", precision: 8, scale: 2
    t.integer "is_opex"
    t.string "extra"
  end

  create_table "divisions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_file_name"
    t.string "file_content_type"
    t.integer "file_file_size"
    t.datetime "file_updated_at"
    t.integer "site_id"
    t.integer "doctype"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "author_id"
    t.string "content"
    t.integer "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "passwords", force: :cascade do |t|
    t.string "secret"
    t.boolean "active"
    t.datetime "last_changed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_id"
  end

  create_table "photo_collections", force: :cascade do |t|
    t.string "title"
    t.integer "site_id"
    t.integer "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.integer "site_id"
    t.integer "message_id"
    t.integer "photo_collection_id"
  end

  create_table "prices", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price", precision: 8, scale: 2
    t.string "unit"
    t.integer "code"
  end

  create_table "role_permissions", force: :cascade do |t|
    t.integer "role_id"
    t.integer "status_id"
    t.string "permissions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "statuses"
    t.index ["role_id", "status_id"], name: "index_role_permissions_on_role_id_and_status_id", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "permissions"
  end

  create_table "site_permissions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "division_id"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "site_roles", force: :cascade do |t|
    t.integer "user_id"
    t.integer "division_id"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "division_id"], name: "index_site_roles_on_user_id_and_division_id", unique: true
  end

  create_table "sites", force: :cascade do |t|
    t.string "network_name"
    t.string "adress_info"
    t.string "distance"
    t.string "access_info"
    t.string "keys_info"
    t.string "power_info"
    t.string "etc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "brigade_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "title"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_first"
    t.boolean "is_hidden"
    t.integer "position"
  end

  create_table "ticket_permissions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "division_id"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ticket_roles", force: :cascade do |t|
    t.integer "user_id"
    t.integer "division_id"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "division_id"], name: "index_ticket_roles_on_user_id_and_division_id", unique: true
  end

  create_table "ticket_types", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "site_id"
    t.integer "author_id"
    t.string "title"
    t.datetime "time_new"
    t.datetime "time_at_site"
    t.datetime "time_done"
    t.integer "status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "brigade_id"
    t.string "number"
    t.integer "ticket_type_id"
    t.datetime "deadline"
    t.string "chrono"
    t.boolean "reported"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
