class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :cns
      t.date :birth_date
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
