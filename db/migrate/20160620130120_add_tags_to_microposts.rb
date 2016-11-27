class AddTagsToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :tags, :text
  end
end
