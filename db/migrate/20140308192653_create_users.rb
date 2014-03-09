class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :full_name
      t.text :bio
      t.string :twitter_handle

      t.timestamps
    end
  end
end
