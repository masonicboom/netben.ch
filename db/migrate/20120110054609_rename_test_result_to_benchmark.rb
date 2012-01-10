class RenameTestResultToBenchmark < ActiveRecord::Migration
  def change
    rename_table :test_results, :benchmarks
  end
end
