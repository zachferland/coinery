class User < ActiveRecord::Base
	has_many :identities
	has_many :products
	has_many :transactions, through: :products             
	has_many :customers, through: :transactions
	has_many :assets, through: :products
	has_many :coinbase_authentications # has one?

  	has_attached_file :image, styles: {large: "200x200"}
	validates_attachment_content_type :image, 
		:content_type => { :content_type => ["image/jpg", "image/png"] }

	def self.create_with_omniauth(info)
		# use info to create a user from twitter info (get image later)
    	create(username: info['nickname'], bio: info['description'], full_name: info['name'], img: info['image'])
  	end

  	def coinbase_auth 
  		coinbase_authentications.last
  	end
end
