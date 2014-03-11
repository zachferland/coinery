class Asset < ActiveRecord::Base
	belongs_to :product

	has_attached_file :asset
	validates_attachment_content_type :asset, :content_type => nil

  # asset type validation and other validation possible here
end
