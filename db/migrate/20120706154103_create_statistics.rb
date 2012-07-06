class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.references :country
      t.references :merchandise
      t.date :date
      t.decimal :minimum, precision: 8, scale: 3

      t.timestamps
    end
    add_index :statistics, :country_id
    add_index :statistics, :merchandise_id
    add_index :statistics, [:merchandise_id, :country_id]

  end
end

