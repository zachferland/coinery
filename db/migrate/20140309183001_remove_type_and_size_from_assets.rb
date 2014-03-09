class RemoveTypeAndSizeFromAssets < ActiveRecord::Migration
  def change
    remove_column :assets, :type, :string
    remove_column :assets, :size, :float
  end
end
