class User < ActiveRecord::Base
	has_many :identities
	has_many :products
	has_many :transactions, through: :products             
	has_many :customers, through: :transactions

	def self.create_with_omniauth(info)
		# use info to create a user from twitter info (get image later)
    	create(username: info['nickname'], bio: info['description'], name: info['name'])
  	end
end
