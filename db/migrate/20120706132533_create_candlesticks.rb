class CreateCandlesticks < ActiveRecord::Migration
  def change
    create_table :candlesticks do |t|
      t.date :date
      t.references :merchandise
      t.references :country
      t.decimal :high, precision: 8, scale: 3
      t.decimal :low, precision: 8, scale: 3
      t.decimal :open, precision: 8, scale: 3
      t.decimal :close, precision: 8, scale: 3
      t.integer :volume

      t.timestamps
    end
    add_index :candlesticks, :merchandise_id
    add_index :candlesticks, :country_id
    add_index :candlesticks, [:merchandise_id, :country_id]
  end
end

