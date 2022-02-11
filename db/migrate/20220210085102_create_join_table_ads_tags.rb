class CreateJoinTableAdsTags < ActiveRecord::Migration[7.0]
  def change
    create_join_table :ads, :tags do |t|
      t.index [:ad_id, :tag_id]
    end
  end
end
