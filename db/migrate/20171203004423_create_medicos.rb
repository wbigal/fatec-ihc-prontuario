class CreateMedicos < ActiveRecord::Migration[5.1]
  def change
    create_table :medicos do |t|
      t.belongs_to :pessoa, null: false, foreign_key: true
      t.integer :crm, null: false
      t.timestamps
      t.index :pessoa_id, unique: true, name: 'ux_medicos_pessoa_id'
    end
  end
end
