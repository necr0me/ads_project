class AddPictureToAds < ActiveRecord::Migration[7.0]
  def change
    add_column :ads, :picture, :string
  end
end
