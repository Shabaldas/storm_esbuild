# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  enum role: { customer: 0, admin: 1, manager: 2 }

  validates :first_name, :last_name, presence: true, on: :update

  def self.from_omniauth(access_token)
    user = User.find_or_initialize_by(email: access_token.info.email) do |u|
      u.password = Devise.friendly_token[0, 20] if u.new_record?
      u.assign_attributes(
        first_name: access_token.info.first_name,
        last_name: access_token.info.last_name,
        uid: access_token.uid,
        provider: access_token.provider
      )
    end

    user.save if user.new_record?
    user
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
