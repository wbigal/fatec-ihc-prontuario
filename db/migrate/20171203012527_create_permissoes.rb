class CreatePermissoes < ActiveRecord::Migration[5.1]
  def change
    create_table :permissoes do |t|
      t.belongs_to :pessoa, null: false, foreign_key: true
      t.belongs_to :medico, null: false, foreign_key: true
      t.belongs_to :atendimento, null: true, foreign_key: true
      t.datetime :data_limite, null: false
      t.datetime :data_autorizacao, null: false
      t.boolean :nao_aceito, null: false, default: false
      t.boolean :revogado, null: false, default: false
      t.timestamps
      t.index :atendimento_id, unique: true,
                               name: 'ux_permissoes_atendimento_id'
    end
  end
end
