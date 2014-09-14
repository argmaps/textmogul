# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140914084415) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "broadcasts", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "broadcasts", ["user_id"], name: "index_broadcasts_on_user_id", using: :btree

  create_table "plans", force: true do |t|
    t.string   "name"
    t.string   "stripe_id"
    t.decimal  "price"
    t.string   "interval"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "plans", ["stripe_id"], name: "index_plans_on_stripe_id", unique: true, using: :btree
  add_index "plans", ["user_id"], name: "index_plans_on_user_id", using: :btree

  create_table "subscriptions", force: true do |t|
    t.string   "stripe_id",        null: false
    t.integer  "plan_id"
    t.integer  "user_id"
    t.integer  "last_four",        null: false
    t.string   "card_type",        null: false
    t.integer  "expiration_month", null: false
    t.integer  "expiration_year",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                                                  null: false
    t.string   "crypted_password",                                       null: false
    t.string   "salt",                                                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "subdomain"
    t.string   "stripe_secret_key"
    t.string   "stripe_publishable_key"
    t.integer  "user_id"
    t.string   "first_name",                                             null: false
    t.string   "last_name",                                              null: false
    t.integer  "phone"
    t.string   "type",                            default: "Subscriber"
    t.string   "country"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree
  add_index "users", ["subdomain"], name: "index_users_on_subdomain", unique: true, using: :btree
  add_index "users", ["user_id"], name: "index_users_on_user_id", using: :btree

end
