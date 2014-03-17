class Notifier < ActionMailer::Base
  default from: "hello@coinery.com"

  def send_signup_email(user)
    @user = user
    mail(
      to: @user.email,
      subject: "Welcome to Coinery!"
    )
  end

  # def send_purchase_email(product, customer)
  # 	@customer = customer
  #   mail(
  #     to: @customer.email,
  #     subject: "Download your purchase from coinery!"
  #     # make this most custome after, have it come from the seller, not coinery, have the name of the product etc.
  #   )
  # end

  def send_purchase_email(product)

    @product = product
    @user = @product.user
    @assets = @product.assets
   
    mail(
      to: "Zachferland@gmail.com",
      subject: "Download your purchase from coinery!"
      # make this most custome after, have it come from the seller, not coinery, have the name of the product etc.
    )
  end

end
