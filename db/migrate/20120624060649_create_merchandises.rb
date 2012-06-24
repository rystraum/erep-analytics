class CreateMerchandises < ActiveRecord::Migration
  def change
    create_table :merchandises do |t|
      t.integer :quality
      t.integer :erep_item_code

      t.timestamps
    end

    add_index :merchandises, [:quality, :erep_item_code]
  end
end

