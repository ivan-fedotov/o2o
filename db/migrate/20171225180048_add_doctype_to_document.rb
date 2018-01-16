class AddDoctypeToDocument < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :doctype, :integer
  end
end
