class CreateDoctors < ActiveRecord::Migration[5.1]
  def change
    create_table :doctors do |t|
      t.references :person, foreign_key: true
      t.string :crm

      t.timestamps
    end
  end
end
