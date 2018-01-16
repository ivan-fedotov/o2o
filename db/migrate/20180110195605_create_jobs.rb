class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
