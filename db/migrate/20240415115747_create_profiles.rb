class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :bio
      t.integer :role, default: 0 # Use enum to set available roles
      t.timestamps
      t.references :user, null: false, foreign_key: true
    end
  end
end
