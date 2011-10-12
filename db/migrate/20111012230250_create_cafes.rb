class CreateCafes < ActiveRecord::Migration
  def change
    create_table :cafes do |t|
      t.string :google_id
      t.string :name
      t.decimal :latitude, :precision => 15, :scale => 10
      t.decimal :longitude, :precision => 15, :scale => 10

      t.timestamps
    end
  end
end
