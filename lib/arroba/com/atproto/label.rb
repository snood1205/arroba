# frozen_string_literal: true

module Arroba
  class Com
    class ATProto
      class Label < BaseResource
        include Validations::Limitable
        get_with_enforced_limit :query_labels, :uri_patterns, sources: nil, max: 250
      end
    end
  end
end
