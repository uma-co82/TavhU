class RenamePrivilegesColumnToPrivileges < ActiveRecord::Migration[5.2]
  def change
    rename_column :privileges, :privilege, :content
  end
end
