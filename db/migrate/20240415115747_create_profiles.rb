class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :name, null: false
      t.string :bio
      t.integer :role, null: false, default: 0
      t.timestamps
      t.references :user, null: false, foreign_key: true
    end
  end
end
