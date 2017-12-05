class AddUniqueKeyCrmOnMedicosTable < ActiveRecord::Migration[5.1]
  def change
    add_index :medicos, :crm, unique: true, name: 'ux_medicos_crm'
  end
end
