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

ActiveRecord::Schema.define(version: 20171203012527) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "atendimentos", force: :cascade do |t|
    t.bigint "pessoa_id", null: false
    t.bigint "medico_id", null: false
    t.datetime "data_atendimento", null: false
    t.text "sintomas", null: false
    t.text "diagnosticos", null: false
    t.text "prescricao_medicamentos", null: false
    t.text "prescricao_procedimentos", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medico_id"], name: "index_atendimentos_on_medico_id"
    t.index ["pessoa_id"], name: "index_atendimentos_on_pessoa_id"
  end

  create_table "medicos", force: :cascade do |t|
    t.bigint "pessoa_id", null: false
    t.integer "crm", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pessoa_id"], name: "index_medicos_on_pessoa_id"
    t.index ["pessoa_id"], name: "ux_medicos_pessoa_id", unique: true
  end

  create_table "permissoes", force: :cascade do |t|
    t.bigint "pessoa_id", null: false
    t.bigint "medico_id", null: false
    t.bigint "atendimento_id"
    t.datetime "data_limite", null: false
    t.datetime "data_autorizacao", null: false
    t.boolean "nao_aceito", default: false, null: false
    t.boolean "revogado", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["atendimento_id"], name: "index_permissoes_on_atendimento_id"
    t.index ["atendimento_id"], name: "ux_permissoes_atendimento_id", unique: true
    t.index ["medico_id"], name: "index_permissoes_on_medico_id"
    t.index ["pessoa_id"], name: "index_permissoes_on_pessoa_id"
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

  add_foreign_key "atendimentos", "medicos"
  add_foreign_key "atendimentos", "pessoas"
  add_foreign_key "medicos", "pessoas"
  add_foreign_key "permissoes", "atendimentos"
  add_foreign_key "permissoes", "medicos"
  add_foreign_key "permissoes", "pessoas"
end
