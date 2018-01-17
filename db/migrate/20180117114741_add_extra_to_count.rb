class AddExtraToCount < ActiveRecord::Migration[5.1]
  def change
    add_column :counts, :extra, :string
  end
end
