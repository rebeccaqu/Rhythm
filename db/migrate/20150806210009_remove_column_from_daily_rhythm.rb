class RemoveColumnFromDailyRhythm < ActiveRecord::Migration
  def change
    remove_column :daily_rhythms, :first_day_of_cycle, :boolean
  end
end
