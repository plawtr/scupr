class CreateBusinessUsers < ActiveRecord::Migration
  def change
    create_table :business_users do |t|
      t.string :uuid
      t.integer :business_id

      t.timestamps
    end
  end
end
