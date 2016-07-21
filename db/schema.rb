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

ActiveRecord::Schema.define(version: 20160721012533) do

  create_table "articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "code",                                null: false
    t.string   "name",                                null: false
    t.string   "description",                         null: false
    t.integer  "percentage",                          null: false
    t.decimal  "cost_price",  precision: 9, scale: 2, null: false
    t.integer  "mark_id",                             null: false
    t.integer  "category_id",                         null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["category_id"], name: "index_articles_on_category_id", using: :btree
    t.index ["mark_id"], name: "index_articles_on_mark_id", using: :btree
  end

  create_table "articles_providers", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "article_id"
    t.integer "provider_id"
    t.index ["article_id"], name: "index_articles_providers_on_article_id", using: :btree
    t.index ["provider_id"], name: "index_articles_providers_on_provider_id", using: :btree
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "historics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.decimal  "cost_price", precision: 9, scale: 2, null: false
    t.integer  "article_id",                         null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["article_id"], name: "index_historics_on_article_id", using: :btree
  end

  create_table "marks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "providers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",        null: false
    t.string   "contact"
    t.integer  "category_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_providers_on_category_id", using: :btree
  end

  create_table "sale_lines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "sale_id",                                          null: false
    t.integer  "article_id",                                       null: false
    t.integer  "article_amount",                                   null: false
    t.decimal  "article_final_price_unit", precision: 9, scale: 2, null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.index ["article_id"], name: "index_sale_lines_on_article_id", using: :btree
    t.index ["sale_id"], name: "index_sale_lines_on_sale_id", using: :btree
  end

  create_table "sales", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.decimal  "total_price", precision: 9, scale: 2, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "stocks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "current_amount", null: false
    t.integer  "minimum_amount", null: false
    t.integer  "article_id",     null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["article_id"], name: "index_stocks_on_article_id", using: :btree
  end

end
