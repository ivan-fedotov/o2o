class AddAccountsRolesTable < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts_roles, id: false do |t|
      t.integer :role_id
      t.integer :status_id
      t.string :permissions

      t.timestamps
    end
    add_index :accounts_roles, [:role_id, :status_id], unique: true
  end
end
