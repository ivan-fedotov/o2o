class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.integer :site_id
      t.integer :author_id
      t.string :title
      t.datetime :time_new
      t.datetime :time_at_site
      t.datetime :time_done
      t.integer :status_id

      t.timestamps
    end
  end
end
