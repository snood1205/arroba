# frozen_string_literal: true

module Arroba
  module ResponseHandler
    class << self
      def handle(response_as_hash, class_name)
        transform_hash_to_be_converted_to_struct response_as_hash, class_name
      end

      private

      def transform_hash_to_be_converted_to_struct(hash_to_transform, class_name, debug: false)
        puts hash_to_transform.inspect if debug
        transformed_hash = hash_to_transform.each_with_object({}) do |(key, value), new_hash|
          snake_key = snakify key
          new_hash[snake_key] = case value
                                when Hash
                                  transform_hash_to_be_converted_to_struct value, "#{class_name}::#{key.capitalize}"
                                else value
                                end
        end
        derive_struct_from_hash transformed_hash, class_name
      end

      def derive_struct_from_hash(hash, class_name)
        klass = Object.const_get class_name
        keys_as_symbols = hash.keys.map(&:to_sym)
        struct = klass.const_set 'Response', Struct.new(*keys_as_symbols, keyword_init: true)
        struct.new(**hash)
      end

      def snakify(camelized)
        camelized.split(/(?=[A-Z])/).map(&:downcase).join('_')
      end
    end
  end
end
