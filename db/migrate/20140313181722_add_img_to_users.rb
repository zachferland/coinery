class AddImgToUsers < ActiveRecord::Migration
  def change
    add_column :users, :img, :string
  end
end
