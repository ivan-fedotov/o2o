class AddUniqIndexToSiteRole < ActiveRecord::Migration[5.1]
  def change
    add_index :site_roles, [:user_id, :division_id], :unique => true
  end
end
