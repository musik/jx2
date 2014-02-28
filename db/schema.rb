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

ActiveRecord::Schema.define(:version => 20140226132025) do

  create_table "categories", :force => true do |t|
    t.string  "name"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
    t.integer "drugs_count", :default => 0
  end

  add_index "categories", ["lft", "rgt"], :name => "index_lr"
  add_index "categories", ["parent_id", "lft"], :name => "index_plr"
  add_index "categories", ["parent_id"], :name => "index_parent"

  create_table "chengfens", :force => true do |t|
    t.string "name"
    t.text   "meta"
    t.string "shouzi"
  end

  add_index "chengfens", ["name"], :name => "index_chengfens_on_name"

  create_table "chengfens_drugs", :id => false, :force => true do |t|
    t.integer "chengfen_id"
    t.integer "drug_id"
  end

  add_index "chengfens_drugs", ["chengfen_id", "drug_id"], :name => "index_chengfens_drugs_on_chengfen_id_and_drug_id"

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "province_id"
    t.integer  "level"
    t.string   "zip_code"
    t.string   "pinyin"
    t.string   "pinyin_abbr"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "cities", ["level"], :name => "index_cities_on_level"
  add_index "cities", ["name"], :name => "index_cities_on_name"
  add_index "cities", ["pinyin"], :name => "index_cities_on_pinyin"
  add_index "cities", ["pinyin_abbr"], :name => "index_cities_on_pinyin_abbr"
  add_index "cities", ["province_id"], :name => "index_cities_on_province_id"
  add_index "cities", ["zip_code"], :name => "index_cities_on_zip_code"

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type", :default => ""
    t.string   "title",            :default => ""
    t.text     "body"
    t.string   "subject",          :default => ""
    t.integer  "user_id",          :default => 0,  :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "author_name"
    t.string   "author_ip"
    t.string   "author_email"
    t.boolean  "approved"
  end

  add_index "comments", ["approved", "created_at"], :name => "approved_created_at"
  add_index "comments", ["approved"], :name => "index_comments_on_approved"
  add_index "comments", ["commentable_id", "commentable_type"], :name => "commentable"
  add_index "comments", ["created_at"], :name => "index_comments_on_created_at"
  add_index "comments", ["parent_id"], :name => "index_comments_on_parent_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "short"
    t.integer  "city_id"
    t.integer  "province_id"
    t.string   "address"
    t.integer  "yaopins_count"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "companies", ["city_id"], :name => "index_companies_on_city_id"
  add_index "companies", ["province_id"], :name => "index_companies_on_province_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "districts", :force => true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.string   "pinyin"
    t.string   "pinyin_abbr"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "districts", ["city_id"], :name => "index_districts_on_city_id"
  add_index "districts", ["name"], :name => "index_districts_on_name"
  add_index "districts", ["pinyin"], :name => "index_districts_on_pinyin"
  add_index "districts", ["pinyin_abbr"], :name => "index_districts_on_pinyin_abbr"

  create_table "drugs", :force => true do |t|
    t.string   "name"
    t.string   "en"
    t.string   "abbr"
    t.string   "abbr2"
    t.integer  "yaopins_count"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "category_id"
    t.text     "shuoming"
    t.boolean  "has_shuoming"
    t.text     "meta"
    t.string   "description"
    t.string   "shouzi"
    t.integer  "items_count",   :default => 0
  end

  add_index "drugs", ["category_id"], :name => "index_drug_category"
  add_index "drugs", ["name"], :name => "index_drugs_on_name"
  add_index "drugs", ["yaopins_count"], :name => "index_yaopins_count"

  create_table "entries", :force => true do |t|
    t.string   "title"
    t.integer  "yaopin_id"
    t.string   "chengfen"
    t.string   "yongfa"
    t.string   "zhuzhi"
    t.string   "name"
    t.string   "guige"
    t.string   "changjia_name"
    t.string   "pihao"
    t.string   "tags_input"
    t.text     "description"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "user_id"
    t.integer  "views",         :default => 0
    t.string   "contact"
    t.string   "phone"
    t.string   "company_name"
  end

  add_index "entries", ["yaopin_id"], :name => "index_entries_on_yaopin_id"

  create_table "items", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.decimal  "price",      :precision => 6, :scale => 2
    t.integer  "yaopin_id"
    t.string   "scope"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "items", ["yaopin_id"], :name => "index_items_on_yaopin_id"

  create_table "ji_items", :force => true do |t|
    t.integer  "jibing_id"
    t.integer  "drug_id"
    t.integer  "position",   :default => 1
    t.integer  "likes",      :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "ji_items", ["drug_id"], :name => "index_ji_items_on_drug_id"
  add_index "ji_items", ["jibing_id"], :name => "index_ji_items_on_jibing_id"

  create_table "jibings", :force => true do |t|
    t.string   "name",                       :null => false
    t.integer  "items_count", :default => 0
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.text     "description"
  end

  create_table "links", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.boolean  "published",    :default => true
    t.integer  "priority",     :default => 5
    t.string   "context"
    t.boolean  "inhome",       :default => true
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "nofollow",     :default => false
    t.integer  "favicon_type", :default => 1
  end

  create_table "options", :force => true do |t|
    t.string   "name"
    t.text     "data"
    t.boolean  "autoload"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "page_views", :force => true do |t|
    t.string   "viewable_type"
    t.integer  "viewable_id"
    t.string   "user_agent"
    t.string   "ip"
    t.string   "referer"
    t.string   "visitor_hash"
    t.integer  "user_id"
    t.datetime "created_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "publish"
    t.string   "laiyuan"
    t.string   "laiyuan_url"
    t.string   "author"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "excerpt"
    t.string   "keywords"
    t.string   "seo_title"
    t.integer  "post_type_cd", :default => 0
    t.string   "related"
    t.boolean  "delta",        :default => true, :null => false
  end

  add_index "posts", ["publish"], :name => "index_posts_on_publish"

  create_table "provinces", :force => true do |t|
    t.string   "name"
    t.string   "pinyin"
    t.string   "pinyin_abbr"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "provinces", ["name"], :name => "index_provinces_on_name"
  add_index "provinces", ["pinyin"], :name => "index_provinces_on_pinyin"
  add_index "provinces", ["pinyin_abbr"], :name => "index_provinces_on_pinyin_abbr"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "shops", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "affurl"
    t.boolean  "linked"
    t.string   "cert"
    t.string   "company_name"
    t.string   "service"
    t.string   "owner"
    t.string   "address"
    t.string   "domain"
    t.date     "reg_in"
    t.date     "expires_in"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "pr",           :limit => 1
    t.integer  "br",           :limit => 1
    t.integer  "alexa"
    t.integer  "priority",     :limit => 1
  end

  add_index "shops", ["domain"], :name => "index_shops_on_domain"

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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "entries_count",          :default => 0
    t.string   "contact"
    t.string   "phone"
    t.string   "company_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "yaopins", :force => true do |t|
    t.string   "name"
    t.string   "en"
    t.string   "wenhao"
    t.string   "yuanwenhao"
    t.string   "benweima"
    t.string   "benweima_beizhu"
    t.string   "shangpin_name"
    t.string   "changjia_name"
    t.string   "changjia_guojia"
    t.string   "changjia_dizhi"
    t.string   "guige"
    t.string   "jixing"
    t.string   "leibie"
    t.date     "pizhunri"
    t.date     "daoqiri"
    t.text     "meta"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "drug_id"
    t.datetime "found_at"
  end

  add_index "yaopins", ["drug_id"], :name => "index_drug_id"
  add_index "yaopins", ["wenhao"], :name => "index_yaopins_on_wenhao"

end
