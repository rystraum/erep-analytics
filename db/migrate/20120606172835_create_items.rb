class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :country
      t.string :item_type
      t.string :item_quality
      t.text :data

      t.timestamps
    end
  end
end
