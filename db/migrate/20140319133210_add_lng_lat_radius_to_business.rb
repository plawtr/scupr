class AddLngLatRadiusToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :lat, :float
    add_column :businesses, :lng, :float
    add_column :businesses, :radius, :float
  end
end
