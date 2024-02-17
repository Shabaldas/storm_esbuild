# frozen_string_literal: true

module Dredd
  class UsersController < BaseController
    before_action :set_user, only: [:edit, :update, :show]

    def index
      @admins = User.where(role: :admin)
      @pagy, @customers = pagy(User.where(role: :customer).order(created_at: :asc), items: 20)
    end

    def show; end
    def edit; end

    def update
      if @user.update(user_params)
        flash.now[:notice] = { text: 'User was successfully updated.', icon: 'success_icon' }.stringify_keys
        render turbo_stream: [
          turbo_stream.replace(@user, @user),
          turbo_stream.prepend('flash', partial: 'dredd/shared/flash')
        ]
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :role, :phone, :provider)
    end
  end
end
