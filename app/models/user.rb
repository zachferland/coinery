class User < ActiveRecord::Base
	has_many :products
	has_many :transactions, through: :products             
	has_many :customers, through: :transactions
end
