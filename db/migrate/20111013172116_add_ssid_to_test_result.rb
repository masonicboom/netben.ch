class AddSsidToTestResult < ActiveRecord::Migration
  def change
    add_column :test_results, :ssid, :string
  end
end
