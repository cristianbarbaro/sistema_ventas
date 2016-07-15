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

ActiveRecord::Schema.define(version: 20160715114818) do

  create_table "articles", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description", null: false
    t.integer  "percentage",  null: false
    t.decimal  "price",       null: false
    t.integer  "mark_id",     null: false
    t.integer  "category_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "historics", force: :cascade do |t|
    t.date     "discharge_date", null: false
    t.decimal  "cost_price",     null: false
    t.integer  "article_id",     null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "lines", force: :cascade do |t|
    t.integer  "sale_id",                  null: false
    t.integer  "article_id",               null: false
    t.integer  "article_amount",           null: false
    t.decimal  "article_final_price_unit", null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "marks", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "providers", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "category_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "sales", force: :cascade do |t|
    t.decimal  "total_price", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.integer  "current_amount", null: false
    t.integer  "minimum_amount", null: false
    t.integer  "article_id",     null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end
