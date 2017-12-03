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

ActiveRecord::Schema.define(version: 20171203004423) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "medicos", force: :cascade do |t|
    t.bigint "pessoa_id", null: false
    t.integer "crm", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pessoa_id"], name: "index_medicos_on_pessoa_id"
    t.index ["pessoa_id"], name: "ux_medicos_pessoa_id", unique: true
  end

  create_table "pessoas", force: :cascade do |t|
    t.string "cns", limit: 16, null: false
    t.string "nome_completo", limit: 255, null: false
    t.date "data_nascimento", null: false
    t.string "email", limit: 100
    t.string "senha", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cns"], name: "index_pessoas_on_cns", unique: true
    t.index ["email", "senha"], name: "index_pessoas_on_email_and_senha"
    t.index ["email"], name: "index_pessoas_on_email", unique: true
  end

  add_foreign_key "medicos", "pessoas"
end
