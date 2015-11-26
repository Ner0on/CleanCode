class DropTables < ActiveRecord::Migration
  def change
    drop_table :states
    drop_table :cities
  end
end
