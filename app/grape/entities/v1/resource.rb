# frozen_string_literal: true

module Entities
  module V1
    class Resource < Entity
      expose :id, format_with: :stringify
      expose :object, proc: proc { self.class.name.demodulize.snakecase }
    end
  end
end
