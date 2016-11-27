class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.text :body
      t.text :title
      t.text :category

      t.timestamps null: false
    end
  end
end
