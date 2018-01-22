class AddStatusesToRolePermission < ActiveRecord::Migration[5.1]
  def change
    add_column :role_permissions, :statuses, :string
  end
end
