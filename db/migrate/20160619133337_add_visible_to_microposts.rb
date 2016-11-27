class AddVisibleToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :visible, :string
  end
end
