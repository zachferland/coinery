class Product < ActiveRecord::Base
	belongs_to :user
	has_many :assets
	has_many :transactions
	has_many :customers, through: :transactions

	has_attached_file :image, styles: {large: "900x900"}
	validates_attachment :image, 
		:content_type => { :content_type => ["image/jpg", "image/png"] }

	def create_payment_code(token)

      response = token.post('/api/v1/buttons', 
                                :params => { button: { name: title, 
                                                       type: 'buy_now', 
                                                       price_string: price,  
                                                       custom:  id,
                                                       price_currency_iso: "USD", 
                                                       callback_url: ENV['ROOT'] + "/api/transactions/callback" }})

      body = response.parsed
      button_code = body['button']['code']

      update(button_code: button_code)
      # # handle a fail??
    end
    

end
