class RenameCafeToPlace < ActiveRecord::Migration
  def change
    rename_table :cafes, :places
    rename_column :test_results, :cafe_id, :place_id
  end
end
