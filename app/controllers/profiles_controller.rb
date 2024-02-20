# frozen_string_literal: true

class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

    render turbo_stream: [
      turbo_stream.replace(@user, partial: 'profiles/form', locals: { user: @user })
    ]
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
