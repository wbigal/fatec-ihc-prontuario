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

ActiveRecord::Schema.define(version: 20171202092837) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "doctor_id"
    t.date "date"
    t.string "symptoms"
    t.string "diagnostic"
    t.string "medicines"
    t.string "procedures"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_attendances_on_doctor_id"
    t.index ["person_id"], name: "index_attendances_on_person_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.bigint "person_id"
    t.string "crm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_doctors_on_person_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "cns"
    t.date "birth_date"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.bigint "attendance_id"
    t.bigint "doctor_id"
    t.bigint "person_id"
    t.boolean "revoke"
    t.boolean "accept"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attendance_id"], name: "index_permissions_on_attendance_id"
    t.index ["doctor_id"], name: "index_permissions_on_doctor_id"
    t.index ["person_id"], name: "index_permissions_on_person_id"
  end

  add_foreign_key "attendances", "doctors"
  add_foreign_key "attendances", "people"
  add_foreign_key "doctors", "people"
  add_foreign_key "permissions", "attendances"
  add_foreign_key "permissions", "doctors"
  add_foreign_key "permissions", "people"
end
