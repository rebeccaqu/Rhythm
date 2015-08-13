class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :name
      t.datetime :starts_at

      t.timestamps null: false
    end
  end
end
