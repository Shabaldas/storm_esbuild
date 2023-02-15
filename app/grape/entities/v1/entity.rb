# frozen_string_literal: true

module Entities
  module V1
    class Entity < Grape::Entity
      include Entities::V1::Concerns::Formatters
    end
  end
end
