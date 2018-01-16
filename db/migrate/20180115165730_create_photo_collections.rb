class CreatePhotoCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :photo_collections do |t|
      t.string :title
      t.integer :site_id
      t.integer :ticket_id

      t.timestamps
    end
  end
end
