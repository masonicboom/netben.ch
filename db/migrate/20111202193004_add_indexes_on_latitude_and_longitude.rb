class AddIndexesOnLatitudeAndLongitude < ActiveRecord::Migration
  def up
    add_index :cafes, :latitude
    add_index :cafes, :longitude
  end

  def down
    remove_index :cafes, :latitude
    remove_index :cafes, :longitude
  end
end
