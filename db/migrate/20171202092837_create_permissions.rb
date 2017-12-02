class CreatePermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions do |t|
      t.references :attendance, foreign_key: true
      t.references :doctor, foreign_key: true
      t.references :person, foreign_key: true
      t.boolean :revoke
      t.boolean :accept
      t.date :date

      t.timestamps
    end
  end
end
