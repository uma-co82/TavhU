class AddColumnToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :author_id, :string
    add_column :shops, :genre_id, :string
    add_column :shops, :station_id, :string
  end
end
