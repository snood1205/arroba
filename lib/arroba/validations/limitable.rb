# frozen_string_literal: true

module Arroba
  module Validations
    module Limitable
      DEFAULT_LIMIT = ->(limit) { enforce_limit! limit, min: 1, max: 100 }.freeze

      def self.enforce_limit!(limit, min:, max:, name: 'Limit')
        puts limit
        return if limit.nil? || (limit.is_a?(Integer) && limit.between?(min, max))

        raise ArgumentError, "#{name} must be an integer between 1 and 100, inclusive"
      end
    end
  end
end
