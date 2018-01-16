class AddMessageIdToPhoto < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :message_id, :integer
  end
end
