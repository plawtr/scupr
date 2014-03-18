class AddBusinessIdToAd < ActiveRecord::Migration
  def change
    add_column :ads, :business_id, :integer
  end
end
