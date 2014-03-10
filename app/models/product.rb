class Product < ActiveRecord::Base
	belongs_to :user
	has_many :assets
	has_many :transactions
	has_many :customers, through: :transactions

	has_attached_file :image #pre processing here
  	# asset type validation and other validation possible here
end
