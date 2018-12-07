class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :shop_id
      t.datetime :start_time
      t.integer :member_count
      t.boolean :approval, default: false

      t.timestamps
    end
  end
end
