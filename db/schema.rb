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

ActiveRecord::Schema.define(version: 20150514105651) do

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.string   "writer"
    t.string   "source"
    t.string   "year"
    t.text     "about"
    t.string   "url"
    t.integer  "book_id"
    t.integer  "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "articles", ["author_id"], name: "index_articles_on_author_id"
  add_index "articles", ["book_id"], name: "index_articles_on_book_id"

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.text     "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "portrait"
  end

  add_index "authors", ["name"], name: "index_authors_on_name"

  create_table "authorships", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authorships", ["author_id"], name: "index_authorships_on_author_id"
  add_index "authorships", ["book_id", "author_id"], name: "index_authorships_on_book_id_and_author_id", unique: true
  add_index "authorships", ["book_id"], name: "index_authorships_on_book_id"

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.integer  "yearofpub"
    t.text     "about"
    t.integer  "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "cover"
    t.string   "pdf"
    t.string   "epub"
  end

  add_index "books", ["genre_id"], name: "index_books_on_genre_id"

  create_table "genres", force: :cascade do |t|
    t.string   "genre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
