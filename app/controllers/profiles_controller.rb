# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authorize_user
  before_action :set_user, only: [:edit_personal_data, :edit_profile_password, :show, :update_personal_data, :update_password]

  def show; end
  def edit_personal_data; end
  def edit_profile_password; end

  def update_personal_data
    handle_update_action('edit_personal_data')
  end

  def update_password
    handle_update_action('edit_profile_password')
  end

  private

  def handle_update_action(edit_partial)
    if @user.update(user_params)
      flash.now[:notice] = { text: 'User was successfully updated.', icon: 'success_icon' }.stringify_keys
      bypass_sign_in(@user) if edit_partial == 'edit_profile_password'
      render turbo_stream: [
        turbo_stream.replace('profile_page', partial: 'profiles/form', locals: { user: @user }),
        turbo_stream.prepend('flash', partial: 'dredd/shared/flash')
      ]
    else
      render edit_partial, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User&.find(params[:id])
  end

  def authorize_user
    set_user

    authorize @user, :access?
  end
end
