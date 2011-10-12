class CreateTestResults < ActiveRecord::Migration
  def change
    create_table :test_results do |t|
      t.integer :cafe_id
      t.float :upload_mbps
      t.float :download_mbps
      t.float :loss_rate

      t.timestamps
    end
  end
end
