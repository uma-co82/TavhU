class RemoveColumnFromShops < ActiveRecord::Migration[5.2]
  def change
    remove_column :shops, :shop_id, :text
    remove_column :shops, :shop_image, :text
  end
end
