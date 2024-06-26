class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user

    mail to: @user.email, subject: 'Welcome to OdinBook!'
  end

  private

  def format_first_name(name)
    name.split[0]
  end
end
