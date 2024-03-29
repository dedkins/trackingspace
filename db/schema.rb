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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130215170712) do

  create_table "ads", :force => true do |t|
    t.integer  "building_id"
    t.integer  "user_id"
    t.string   "slot"
    t.string   "title"
    t.text     "message"
    t.string   "type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "space_id"
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "index"
    t.string   "create"
    t.string   "destroy"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "building_orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "building_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "building_relationships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "building_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "building_relationships", ["building_id"], :name => "index_building_relationships_on_building_id"
  add_index "building_relationships", ["user_id"], :name => "index_building_relationships_on_user_id"

  create_table "buildings", :force => true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.boolean  "gmaps"
    t.integer  "user_id"
    t.string   "status"
    t.decimal  "size"
    t.string   "street_number"
    t.string   "route"
    t.string   "locality"
    t.string   "administrative_area_level_1"
    t.string   "administrative_area_level_2"
    t.string   "postal_code"
    t.string   "country"
    t.string   "slug"
    t.string   "videourl"
    t.integer  "manager"
  end

  add_index "buildings", ["slug"], :name => "index_buildings_on_slug"

  create_table "lease_shares", :force => true do |t|
    t.integer  "lease_id"
    t.integer  "space_id"
    t.integer  "sharedfrom_id"
    t.integer  "sharedto_id"
    t.string   "email"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "leases", :force => true do |t|
    t.integer  "user_id"
    t.integer  "size"
    t.decimal  "current_rate"
    t.date     "expiration"
    t.integer  "space_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "building_id"
    t.integer  "space_id"
    t.integer  "lease_id"
    t.string   "address"
    t.string   "suite"
    t.string   "name"
    t.string   "typeof"
    t.integer  "postforuser_id"
    t.boolean  "propmgmt"
  end

  add_index "microposts", ["user_id"], :name => "index_microposts_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "spaces", :force => true do |t|
    t.integer  "sf"
    t.decimal  "monthly",     :precision => 10, :scale => 2
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "suite"
    t.integer  "user_id"
    t.string   "company"
    t.string   "status"
    t.string   "_3dplanurl"
    t.string   "videourl"
    t.text     "description"
  end

  create_table "sponsors", :force => true do |t|
    t.integer  "sponsoredby_id"
    t.integer  "sponsoredmember_id"
    t.boolean  "accepted"
    t.date     "date_accepted"
    t.string   "email"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "plan_id"
    t.string   "plan_name"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "stripe_card_token"
    t.string   "email"
    t.string   "stripe_customer_token"
  end

  create_table "user_relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_relationships", ["followed_id"], :name => "index_user_relationships_on_followed_id"
  add_index "user_relationships", ["follower_id"], :name => "index_user_relationships_on_follower_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.string   "username"
    t.string   "upgrade"
    t.text     "description"
    t.string   "phone"
    t.string   "website"
    t.string   "access"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "license"
    t.boolean  "broker"
    t.string   "geocity"
    t.string   "geozip"
    t.string   "geostate"
    t.string   "geocountry"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
