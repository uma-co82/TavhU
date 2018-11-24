class Deletetable < ActiveRecord::Migration[5.2]
  def change
    drop_table :active_admin_comments
    drop_table :admin_users
    drop_table :authors
  end
end
