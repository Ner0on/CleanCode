class RenameColumnNameInCities < ActiveRecord::Migration
  def change
    rename_column :cities, :counrty_id, :country_id
  end
end
