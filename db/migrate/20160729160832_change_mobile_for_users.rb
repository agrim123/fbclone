class ChangeMobileForUsers < ActiveRecord::Migration
  def change
  	change_column :users, :mobile, :decimal
  end
end
