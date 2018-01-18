class RemoveUserRole < ActiveRecord::Migration[5.1]
  def change
    drop_table :user_roles
  end
end
