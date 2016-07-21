# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/account_activation_password_reset
  def account_activation
  	user = User.first
  	user.activation_token = User.new_token
    UserMailer.account_activation(user)
  end

  def password_reset
  	UserMailer.password_reset
  end

end
