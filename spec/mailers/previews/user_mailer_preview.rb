class UserMailerPreview < ActionMailer::Preview
  def reset_password_instructions
    user = User.new(email: 'andriubuhal@gmail.com')
    token = 'token123'
    UserMailer.reset_password_instructions(user, token)
  end
end
