class CreateRolePermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :role_permissions do |t|
      t.integer :role_id
      t.integer :status_id
      t.string :permissions

      t.timestamps
    end
    add_index :role_permissions, [:role_id, :status_id], unique: true
  end
end
