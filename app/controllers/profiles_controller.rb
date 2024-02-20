# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :personal_data]

  def show; end
  def edit; end
  def personal_data; end

  def update
    flash.now[:notice] = { text: 'User was successfully updated.', icon: 'success_icon' }.stringify_keys
    if @user.update(user_params)
      bypass_sign_in(@user)
      render turbo_stream: [
        turbo_stream.replace(@user, partial: 'profiles/form', locals: { user: @user }),
        turbo_stream.prepend('flash', partial: 'dredd/shared/flash')
      ]
    else
      render(
        user_params[:password].present? ? :personal_data : :edit,
        status: :unprocessable_entity
      )
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
