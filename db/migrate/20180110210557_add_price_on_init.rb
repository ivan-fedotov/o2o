class AddPriceOnInit < ActiveRecord::Migration[5.1]
  def change
    add_column :counts, :price_on_init, :decimal, :precision => 8, :scale => 2
  end
end
