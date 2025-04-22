# frozen_string_literal: true

module Arroba
  module ResponseHandler
    class << self
      def handle(response_as_hash, class_name)
        transform_hash_to_be_converted_to_struct response_as_hash, class_name
      end

      private

      def transform_hash_to_be_converted_to_struct(hash_to_transform, class_name)
        struct = scaffold_struct_from_hash hash_to_transform, class_name
        transformed_hash = hash_to_transform.each_with_object({}) do |(key, value), new_hash|
          snake_key = snakify key
          new_hash[snake_key] = transform_value value, key, class_name
        end
        struct.new(**transformed_hash)
      end

      def transform_value(value, key, class_name)
        case value
        when Hash
          transform_hash_to_be_converted_to_struct value, "#{class_name}::#{key.capitalize}"
        when Array
          value.map { transform_value it, key, class_name }
        else value
        end
      end

      def scaffold_struct_from_hash(hash, class_name)
        klass = class_from_class_name class_name
        keys_as_symbols = hash.keys.map { |key| snakify(key).to_sym }
        klass.const_set 'Response', Struct.new(*keys_as_symbols, keyword_init: true)
      end

      def class_from_class_name(class_name)
        return Object.const_get class_name if Object.const_defined? class_name

        *base_class_name_array, new_class_name = class_name.split '::'
        base_class = Object.const_get base_class_name_array.join '::'

        base_class.const_set new_class_name, Class.new
      end

      def snakify(camelized)
        camelized.split(/(?=[A-Z])/).map(&:downcase).join('_')
      end
    end
  end
end
