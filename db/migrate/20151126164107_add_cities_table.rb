class AddCitiesTable < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string      :name
      t.belongs_to  :country
      t.belongs_to  :state
    end
  end
end
