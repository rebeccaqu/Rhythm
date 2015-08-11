class AddAcceptedColumnToFriendship < ActiveRecord::Migration
  def change
    add_column :friendships, :accepted, :boolean, default: false
  end
end
