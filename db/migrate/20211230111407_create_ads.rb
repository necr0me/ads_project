class CreateAds < ActiveRecord::Migration[7.0]
  def change
    create_table :ads do |t|
      t.string :name
      t.text :content
      t.integer :status
      t.string :pictures, array: true, default: []
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
    add_index :ads, [:user_id, :created_at]
  end
end
