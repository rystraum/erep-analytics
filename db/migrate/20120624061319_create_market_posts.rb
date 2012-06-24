class CreateMarketPosts < ActiveRecord::Migration
  def change
    create_table :market_posts do |t|
      t.references :merchandise
      t.references :country
      t.references :item
      t.string :provider
      t.integer :stock
      t.decimal :price, precision: 8, scale: 3

      t.timestamps
    end

    add_index :market_posts, :merchandise_id
    add_index :market_posts, :country_id
    add_index :market_posts, :item_id
  end
end

