class RemoveCreatedAtColumns < ActiveRecord::Migration
  def change
    remove_column :countries, :created_at
    remove_column :countries, :updated_at

    remove_column :cities, :created_at
    remove_column :cities, :updated_at

    remove_column :states, :created_at
    remove_column :states, :updated_at
  end
end
