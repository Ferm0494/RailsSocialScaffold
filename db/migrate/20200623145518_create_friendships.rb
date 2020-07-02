class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.string :status
      t.integer :user_id
      t.integer :other_user_id

      t.timestamps
    end
  end
end
