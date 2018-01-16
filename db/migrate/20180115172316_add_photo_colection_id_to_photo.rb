class AddPhotoColectionIdToPhoto < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :photo_collection_id, :integer
  end
end
