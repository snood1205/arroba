# frozen_string_literal: true

require_relative '../validations'

module Arroba
  class BSky
    class Graph < BaseResource
      include Validations::Limitable
      get_with_query_params :actor, limit: nil, cursor: nil, &DEFAULT_LIMIT
    end
  end
end
