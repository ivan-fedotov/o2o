class CreateCounts < ActiveRecord::Migration[5.1]
  def change
    create_table :counts do |t|
      t.integer :price_id
      t.decimal :quantity, :precision => 8, :scale => 2
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
