# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend

  before_action :set_locale

  rescue_from Pundit::NotAuthorizedError do |error|
    redirect_to root_path, alert: pundit_error_message(error)
  end

  def pundit_error_message(error)
    policy = error.try(:policy)
    return default_error_message if policy.nil?

    query = error.try(:query)
    return default_error_message if query.nil?

    policy_namespace = policy.class.name.underscore
    I18n.t query, scope: [:error_message, :pundit, policy_namespace], default: default_error_message
  end

  def default_error_message
    I18n.t('error_message.pundit.default')
  end

  def set_locale
    locale_in_cookies = I18n.available_locales.map(&:to_s).include?(cookies[:locale])
    I18n.locale = locale_in_cookies ? cookies[:locale] : I18n.default_locale
  end

  def current_cart
    cart = Cart.find_or_create_by(token: cookies[:cart_token])
    cookies[:cart_token] ||= cart.token
    cart
  end

  helper_method :current_cart
end
