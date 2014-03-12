class Product < ActiveRecord::Base
	belongs_to :user
	has_many :assets
	has_many :transactions
	has_many :customers, through: :transactions

	has_attached_file :image, styles: {large: "900x900"}
	validates_attachment_content_type :image, 
		:content_type => { :content_type => ["image/jpg", "image/png"] }

	def self.create_payment_code(product, token)

      @response = token.post('/api/v1/buttons', 
                                :params => { button: { name: product.title, 
                                                       type: 'buy_now', 
                                                       price_string: product.price,  
                                                       custom:  product.id,
                                                       price_currency_iso: "USD", 
                                                       callback_url: ENV['ROOT'] + "/api/transactions/callback" }})

      @body = @response.parsed
      button_code = @body['button']['code']

      product.update(button_code: button_code)
      # # handle a fail??
    end

end
