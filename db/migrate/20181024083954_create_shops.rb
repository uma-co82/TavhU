class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.text :shop_name
      t.text :shop_id
      t.text :shop_info
      t.text :shop_image

      t.timestamps
    end
  end
end
