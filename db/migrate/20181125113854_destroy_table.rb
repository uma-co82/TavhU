class DestroyTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :dms
    drop_table :messages
    drop_table :rooms
  end
end
