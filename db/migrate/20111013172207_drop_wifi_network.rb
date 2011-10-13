class DropWifiNetwork < ActiveRecord::Migration
  def up
    drop_table :wifi_networks
  end

  def down
    raise IrreversibleMigration
  end
end
