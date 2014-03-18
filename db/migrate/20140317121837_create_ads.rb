class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.text :caption

      t.timestamps
    end
  end
end
