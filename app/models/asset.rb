class Asset < ActiveRecord::Base
	belongs_to :product

	has_attached_file :asset
  # asset type validation and other validation possible here
end
