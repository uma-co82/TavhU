class RenameColumnToShopsAddress < ActiveRecord::Migration[5.2]
  def change
    rename_column :shops, :address, :address_city
    add_column :shops, :address, :string
  end
end
