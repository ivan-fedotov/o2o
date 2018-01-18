class RemoveDivisionIdFromRole < ActiveRecord::Migration[5.1]
  def change
    remove_column :roles, :division_id, :string
  end
end
