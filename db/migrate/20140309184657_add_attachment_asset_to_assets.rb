class AddAttachmentAssetToAssets < ActiveRecord::Migration
  def self.up
    change_table :assets do |t|
      t.attachment :asset
    end
  end

  def self.down
    drop_attached_file :assets, :asset
  end
end
