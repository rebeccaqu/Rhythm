class CreateDailyRhythms < ActiveRecord::Migration
  def change
    create_table :daily_rhythms do |t|
      t.integer :cycle_num
      t.integer :day_of_cycle
      t.date :date
      t.boolean :period
      t.string :period_flow
      t.float :bbt
      t.string :cervical_fluid
      t.integer :pain
      t.string :mood
      t.string :pill
      t.string :sex

      t.timestamps null: false
    end
  end
end
