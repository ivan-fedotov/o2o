class CreateSiteRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :site_roles do |t|
      t.integer :user_id
      t.integer :division_id
      t.integer :level

      t.timestamps
    end
  end
end
