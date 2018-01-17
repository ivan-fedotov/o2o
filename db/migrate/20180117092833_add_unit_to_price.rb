class AddUnitToPrice < ActiveRecord::Migration[5.1]
  def change
    add_column :prices, :unit, :string
  end
end
