class AddOnwallToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :onwall, :integer
  end
end
