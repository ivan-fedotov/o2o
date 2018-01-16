class AddSiteIdToPhoto < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :site_id, :integer
  end
end
