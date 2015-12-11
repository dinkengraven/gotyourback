class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.references :creator, index: true, foreign_key: true
      t.string :location
      t.integer :duration_in_days
      t.text :route
      t.text :details

      t.timestamps null: false
    end
  end
end
