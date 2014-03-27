class AddAttachmentPassToAds < ActiveRecord::Migration
  def self.up
    change_table :ads do |t|
      t.attachment :pass
    end
  end

  def self.down
    drop_attached_file :ads, :pass
  end
end
