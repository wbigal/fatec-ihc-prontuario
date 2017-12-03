class CreatePessoas < ActiveRecord::Migration[5.1]
  def change
    create_table :pessoas do |t|
      t.string :cns, limit: 16, null: false
      t.string :nome_completo, limit: 255, null: false
      t.date :data_nascimento, null: false
      t.string :email, null: true, limit: 100
      t.string :senha, null: true, limit: 255
      t.timestamps
      t.index [:email, :senha]
      t.index :cns, unique: true
      t.index :email, unique: true
    end
  end
end
