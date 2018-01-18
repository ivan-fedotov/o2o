class AddTitleToRole < ActiveRecord::Migration[5.1]
  def change
    add_column :roles, :title, :string
    remove_column :roles, :user_id
    remove_column :roles, :access_level
  end
end
