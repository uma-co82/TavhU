class CreateSeats < ActiveRecord::Migration[5.2]
  def change
    create_table :seats do |t|
      t.datetime :time
      t.integer :count
      t.boolean :fill, default: false
      t.integer :shop_id

      t.timestamps
    end
  end
end
