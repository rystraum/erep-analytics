class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.datetime :record_date
      t.string :poster_id
      t.integer :stock
      t.decimal :price, precision: 15, scale: 5
      t.integer :item_code
      t.integer :item_quality
      t.integer :country_id

      t.timestamps
    end
  end
end

