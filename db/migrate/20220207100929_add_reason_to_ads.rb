class AddReasonToAds < ActiveRecord::Migration[7.0]
  def change
    add_column :ads, :reason, :string
  end
end
