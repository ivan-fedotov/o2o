class AddSiteIdToDocument < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :site_id, :integer
  end
end
