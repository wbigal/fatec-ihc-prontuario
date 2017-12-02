class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
      t.references :person, foreign_key: true
      t.references :doctor, foreign_key: true
      t.date :date
      t.string :symptoms
      t.string :diagnostic
      t.string :medicines
      t.string :procedures

      t.timestamps
    end
  end
end
