class AddColumnToDailyRhythm < ActiveRecord::Migration
  def change
    add_column :daily_rhythms, :first_day_of_cycle, :boolean
  end
end
