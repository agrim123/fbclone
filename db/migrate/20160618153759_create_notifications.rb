class CreateNotifications < ActiveRecord::Migration  
  def change
    create_table :notifications do |t|
      t.references :user, index: true
      t.references :notified_by, index: true
      t.references :micropost, index: true
      t.integer :identifier
      t.string :notice_type
      t.boolean :read, default: false

      t.timestamps null: false
    end
    add_foreign_key :notifications, :users
    add_foreign_key :notifications, :users, column: :notified_by_id
    add_foreign_key :notifications, :microposts
  end
end  