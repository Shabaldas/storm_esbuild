# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_user, only: [:edit_personal_data, :edit_password, :show, :update_personal_data, :update_password]

  def show; end
  def edit_personal_data; end
  def edit_password; end

  def update_personal_data
    flash.now[:notice] = { text: 'User was successfully updated.', icon: 'success_icon' }.stringify_keys
    @user.update(user_params)
      render turbo_stream: [
        turbo_stream.replace("new", partial: 'profiles/form', locals: { user: @user }),
        turbo_stream.prepend('flash', partial: 'dredd/shared/flash')
      ]
  end

  def update_password
    flash.now[:notice] = { text: 'User was successfully updated.', icon: 'success_icon' }.stringify_keys
    if @user.update(user_params)
      bypass_sign_in(@user)
      render turbo_stream: [
        turbo_stream.replace(@user, partial: 'profiles/form', locals: { user: @user }),
        turbo_stream.prepend('flash', partial: 'dredd/shared/flash')
      ]
    else
      # render(
      #   user_params[:password].present? ? :personal_data : :edit,
      #   status: :unprocessable_entity
      # )
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
