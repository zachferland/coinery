class AddButtonCodeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :button_code, :string
  end
end
