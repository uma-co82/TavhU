class AddDefaultToQuicks < ActiveRecord::Migration[5.2]
  def change
    change_column_default :quicks, :request, false
  end
end
