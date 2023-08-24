# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    handle_auth('Google')
  end

  def handle_auth(kind)
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      flash[:notice] = { text: I18n.t('devise.omniauth_callbacks.success', kind:, icon: 'success_icon') }
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.auth_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_registration_url, error: { text: @user.errors.full_messages.join("\n"), icon: 'attention' }
    end
  end
end
