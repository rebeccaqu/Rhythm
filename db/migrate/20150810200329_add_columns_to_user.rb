class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :physicians, :first_name, :string
    add_column :physicians, :last_name, :string
  end
end
