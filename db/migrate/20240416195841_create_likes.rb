class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :likeable, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end

    add_index :likes, [:likeable_id, :likeable_type, :user_id], unique: true, name: 'index_likes_on_likeable_and_user'
  end
end
