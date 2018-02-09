class AddTextCodeToPrices < ActiveRecord::Migration[5.1]
  def change
    add_column :prices, :text_code, :string
  end
end
