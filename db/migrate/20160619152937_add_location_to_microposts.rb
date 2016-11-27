class AddLocationToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :location, :text
  end
end
