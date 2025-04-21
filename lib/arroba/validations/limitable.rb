# frozen_string_literal: true

module Arroba
  module Validations
    # Limitable is a module that provides functionality to enforce limits on query parameters.
    module Limitable
      DEFAULT_LIMIT = ->(limit: nil, min: 1, max: 100, **) { enforce_limit! limit, min:, max: }.freeze

      def self.enforce_limit!(limit, min:, max:, name: 'Limit')
        return if limit.nil? || (limit.is_a?(Integer) && limit.between?(min, max))

        raise ArgumentError, "#{name} must be an integer between #{min} and #{max}, inclusive"
      end

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def get_with_enforced_limit(method_name, *, limit: nil, cursor: nil, min: 1, max: 100, **)
          basic_get method_name, *, limit:, cursor:, ** do |**query_params|
            DEFAULT_LIMIT.call(limit:, min:, max:, **query_params)

            yield if block_given?
          end
        end
      end
    end
  end
end
