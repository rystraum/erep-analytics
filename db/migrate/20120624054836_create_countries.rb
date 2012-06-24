class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.integer :erep_country_id

      t.timestamps
    end

    add_index :countries, :erep_country_id
  end
end

