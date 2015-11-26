class AddStatesTable < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string        :name
      t.belongs_to    :country      
    end
  end
end
