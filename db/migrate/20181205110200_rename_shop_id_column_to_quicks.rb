class RenameShopIdColumnToQuicks < ActiveRecord::Migration[5.2]
  def change
   rename_column :quicks , :shop_id, :seat_id
  end
end
