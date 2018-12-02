class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :author, :boolean
    add_column :users, :introduce, :text
  end
end
