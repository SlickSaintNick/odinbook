class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :body, null: false
      t.integer :status # 0 public_comment, 1 private_comment, 2 archived_comment
      t.references :post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :comment_reply, foreign_key: { to_table: :comments }
      t.timestamps
    end
  end
end
