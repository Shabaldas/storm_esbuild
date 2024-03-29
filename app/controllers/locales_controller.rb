# frozen_string_literal: true

class LocalesController < ApplicationController
  def update
    cookies[:locale] = params[:locale]
    I18n.locale = params[:locale]
    redirect_back fallback_location: root_path, notice: { text: I18n.t('global.translate'), icon: 'success_icon' }
  end
end
