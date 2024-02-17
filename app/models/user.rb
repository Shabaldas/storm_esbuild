# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  enum role: { customer: 0, admin: 1, manager: 2 }

  validates :first_name, :last_name, presence: true

  def self.from_omniauth(access_token)
    user = User.where(email: access_token.info.email).first
    user ||= User.create(
      email: access_token.info.email,
      password: Devise.friendly_token[0, 20]
    )
    user.first_name = access_token.info.name
    user.uid = access_token.uid
    user.provider = access_token.provider
    user.save

    user
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def validate_names_presence
    return unless first_name.blank? || last_name.blank?

    errors.add(:first_name, :blank) if first_name.blank?
    errors.add(:last_name, :blank) if last_name.blank?
    throw(:abort)
  end
end
