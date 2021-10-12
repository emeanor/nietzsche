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

ActiveRecord::Schema.define(version: 2021_10_12_160623) do

  create_table "texts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "nietzsche_number", null: false
    t.integer "kgw_notebook_number", null: false
    t.integer "kgw_text_number", null: false
    t.integer "book_number"
    t.integer "duplicate"
    t.string "url_slug", null: false
    t.string "title", null: false
    t.text "text", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["nietzsche_number"], name: "index_texts_on_nietzsche_number"
    t.index ["url_slug"], name: "index_texts_on_url_slug", unique: true
  end

end
