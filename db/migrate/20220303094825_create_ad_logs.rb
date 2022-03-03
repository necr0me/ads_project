class CreateAdLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :ad_logs do |t|
      t.integer :from
      t.integer :to
      t.integer :by_user_id
      t.string :reason
      t.references :ad, index: true, foreign_key: true

      t.timestamps
    end
    add_index :ad_logs, [:ad_id, :created_at]
  end
end
