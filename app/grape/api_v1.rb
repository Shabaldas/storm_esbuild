# frozen_string_literal: true

class ApiV1 < Grape::API
  version 'v1', using: :path
  format :json

  mount Api::V1::Resources::ProductCategories
end
