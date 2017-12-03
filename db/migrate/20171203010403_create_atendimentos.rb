class CreateAtendimentos < ActiveRecord::Migration[5.1]
  def change
    create_table :atendimentos do |t|
      t.belongs_to :pessoa, null: false, foreign_key: true, index: true
      t.belongs_to :medico, null: false, foreign_key: true, index: true
      t.datetime :data_atendimento, null: false
      t.text :sintomas, null: false
      t.text :diagnosticos, null: false
      t.text :prescricao_medicamentos, null: false
      t.text :prescricao_procedimentos, null: false
      t.timestamps
    end
  end
end
