class RemovePublishedFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :published, :boolean
  end
end
