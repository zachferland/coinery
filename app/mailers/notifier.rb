class Notifier < ActionMailer::Base
  default from: "hello@coinery.com"

  def send_signup_email(user)
    @user = user
    mail(
      to: @user.email,
      subject: "Welcome to Coinery!"
    )
  end
end
