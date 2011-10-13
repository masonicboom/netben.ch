class CreateWifiNetworks < ActiveRecord::Migration
  def change
    create_table :wifi_networks do |t|
      t.integer :cafe_id
      t.string :ssid

      t.timestamps
    end
  end
end
