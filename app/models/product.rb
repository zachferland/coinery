class Product < ActiveRecord::Base
	belongs_to :user
	has_many :assets
	has_many :transactions
	has_many :customers, through: :transactions

	has_attached_file :image, styles: {large: "900x900"}
	validates_attachment_content_type :image, 
		:content_type => { :content_type => ["image/jpg", "image/png"] }
end
