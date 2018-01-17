class AddCodeToPrice < ActiveRecord::Migration[5.1]
  def change
    add_column :prices, :code, :integer
  end
end
