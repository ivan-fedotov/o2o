class AddDecimalToPrices < ActiveRecord::Migration[5.1]
  def change
    remove_column :prices, :price
    add_column :prices, :price, :decimal, :precision => 8, :scale => 2
  end
end
