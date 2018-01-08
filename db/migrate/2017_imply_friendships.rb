class ImplyFriendships < ActiveRecord::Migration
  def change
    create_table :implyfriendships do |t|
      t.integer :user_id, index: true
      t.integer :implyfriend_id, index: true

      t.timestamps null: false
    end
  end
end