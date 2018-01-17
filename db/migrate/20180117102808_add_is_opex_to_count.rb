class AddIsOpexToCount < ActiveRecord::Migration[5.1]
  def change
    add_column :counts, :is_opex, :integer
  end
end
