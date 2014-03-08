class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.integer :product_id
      t.string :type
      t.float :size

      t.timestamps
    end
  end
end
