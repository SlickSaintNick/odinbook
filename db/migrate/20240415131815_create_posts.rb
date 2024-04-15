class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :body, null: false
      t.integer :status, null: false, default: 0 # 0 public, 1 private, 2 archived
      t.timestamps
      t.references :user, null: false, foreign_key: true
    end
  end
end
