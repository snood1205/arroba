# frozen_string_literal: true

module Arroba
  module ResponseHandler
    class << self
      def handle(response_as_hash, class_name)
        transform_hash_to_be_converted_to_struct response_as_hash, class_name
      end

      private

      def transform_hash_to_be_converted_to_struct(hash_to_transform, class_name, indices = {})
        struct = scaffold_struct_from_hash hash_to_transform, class_name, indices
        transformed_hash = hash_to_transform.each_with_object({}) do |(key, value), new_hash|
          snake_key = snakify key
          new_hash[snake_key] = transform_value value, key, class_name, indices
        end
        struct.new(**transformed_hash)
      end

      def transform_value(value, key, class_name, indices)
        case value
        when Hash
          transform_hash_to_be_converted_to_struct value, "#{class_name}::#{key.capitalize}", indices
        when Array
          value.map.with_index { |val, idx| transform_value val, key, class_name, indices.merge(key.capitalize => idx) }
        else value
        end
      end

      def scaffold_struct_from_hash(hash, class_name, indices)
        klass = class_from_class_name class_name, indices
        keys_as_symbols = hash.keys.map { |key| snakify(key).to_sym }
        klass.const_set 'Response', Struct.new(*keys_as_symbols, keyword_init: true)
      end

      def class_from_class_name(class_name, indices)
        return Object.const_get class_name if Object.const_defined? class_name

        *base_class_names, new_class_name = class_name.split '::'
        indexed_base_class_names = index_base_class_names base_class_names, indices
        new_class_index = indices[new_class_name]
        base_class = determine_base_class indexed_base_class_names, new_class_index

        base_class.const_set new_class_name, Class.new
      end

      def index_base_class_names(base_class_names, indices)
        base_class_names.map do |base_class_name|
          indices.key?(base_class_name) ? "#{base_class_name}#{indices[base_class_name]}" : base_class_name
        end
      end

      def determine_base_class(indexed_base_class_names, new_class_index)
        if new_class_index.nil?
          begin
            Object.const_get indexed_base_class_names.join '::'
          rescue NameError
            binding.pry
          end
        else
          define_array_indexed_class indexed_base_class_names.join('::'), new_class_index
        end
      end

      def define_array_indexed_class(class_name, index)
        *base_class_name_array, array_indexed_class = class_name.split '::'
        base_class = Object.const_get base_class_name_array.join '::'
        base_class.const_set "#{array_indexed_class}#{index}", Class.new
      end

      def snakify(camelized)
        camelized.split(/(?=[A-Z])/).map(&:downcase).join('_')
      end
    end
  end
end
