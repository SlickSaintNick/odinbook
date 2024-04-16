class CreateFollows < ActiveRecord::Migration[7.1]
  def change
    create_table :follows do |t|
      t.references :following_user, foreign_key: { to_table: :users }, null: false
      t.references :followed_user, foreign_key: { to_table: :users }, null: false
      t.integer :status, null: false, default: 0
      t.timestamps
      t.index [:following_user_id, :followed_user_id], unique: true
    end
  end
end
