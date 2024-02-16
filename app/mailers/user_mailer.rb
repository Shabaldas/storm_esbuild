# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def reset_password_instructions(user, token)
    @user = user
    @token = token
    mail(to: @user.email, subject: t('devise.mailer.reset_password_instructions.subject'))
  end
end
