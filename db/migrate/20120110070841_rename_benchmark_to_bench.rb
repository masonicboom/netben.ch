class RenameBenchmarkToBench < ActiveRecord::Migration
  def change
    rename_table :benchmarks, :benches
  end
end
