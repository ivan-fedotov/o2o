class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.integer :division_id
      t.integer :user_id
      t.integer :access_level

      t.timestamps
    end
  end
end
