class AddPermissionsToPRole < ActiveRecord::Migration[5.1]
  def change
    add_column :roles, :permissions, :string
  end
end
