class AddForeignKeyToDailyRhythm < ActiveRecord::Migration
  def change
    add_column :daily_rhythms, :user_id, :integer
  end
end
