class AddColumnsToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :user_id, :string
    add_column :rooms, :opponent_id, :string
  end
end
