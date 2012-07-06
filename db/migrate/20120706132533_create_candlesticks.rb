class CreateCandlesticks < ActiveRecord::Migration
  def change
    create_table :candlesticks do |t|
      t.date :date
      t.references :merchandise
      t.references :country
      t.decimal :high
      t.decimal :low
      t.decimal :open
      t.decimal :close
      t.integer :volume

      t.timestamps
    end
    add_index :candlesticks, :merchandise_id
    add_index :candlesticks, :country_id
    add_index :candlesticks, [:merchandise_id, :country_id]
  end
end

