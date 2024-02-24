# frozen_string_literal: true

class Client < ApplicationRecord
  # associations
  has_many :manual_orders # rubocop:disable Rails/HasManyOrHasOneDependent

  # validations
  validates :first_name, presence: true
  validates :phone_number, uniqueness: true

  ransack_alias :name, [:first_name, :last_name]

  ransacker :email, formatter: proc { |v| v.downcase } do |parent|
    parent.table[:email]
  end

  ransacker :nickname, formatter: proc { |v| v.downcase } do |parent|
    parent.table[:nickname]
  end

  ransacker :phone_number, formatter: proc { |v| v.downcase } do |parent|
    parent.table[:phone_number]
  end

  ransacker :full_name do |parent|
    Arel::Nodes::NamedFunction.new('CONCAT_WS', [
                                     Arel::Nodes.build_quoted(' '), parent.table[:first_name], parent.table[:last_name]
                                   ])
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
