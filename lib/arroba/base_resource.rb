# frozen_string_literal: true

require_relative 'validations'

module Arroba
  # Serves as a base class for all resources in the Arroba gem.
  #
  # This class provides a set of methods for making HTTP requests to the
  # Arroba API. It also includes utility methods for constructing URLs and
  # validating parameters.
  #
  # @abstract
  #
  # @see Arroba::Client
  # @see Arroba::BSky
  # @see Arroba::Validations
  class BaseResource
    def get(**) = request(:get, **)
    def post(**) = request(:post, **)
    def put(**) = request(:put, **)
    def delete(**) = request(:delete, **)

    def self.inherited(subclass)
      super
      subclass.extend ClassMethods
    end

    module ClassMethods
      def basic_get(method_name, *required_params, **optional_params)
        allowed_params = required_params + optional_params.keys

        define_method method_name do |**initial_query_params|
          validate_missing! required_params, initial_query_params
          validate_extra! allowed_params, initial_query_params
          query_params = merge_query_params optional_params, initial_query_params

          yield(**query_params) if block_given?
          url = construct_url self.class.name, method_name
          return request(:get, url:) if query_params.empty?

          camelized_query_params = query_params.transform_keys { |key| camelize key.to_s }

          request :get, url:, query_params: camelized_query_params
        end
      end

      def basic_post(method_name, *required_params)
        define_method "#{method_name}!" do |**body|
          validate_missing! required_params, body
          validate_extra! required_params, body
          camelized_body = body.transform_keys { |key| camelize key.to_s }
          url = construct_url self.class.name, method_name
          request :post, url:, body: camelized_body
        end
      end
    end

    protected

    def merge_query_params(optional_params, initial_query_params) = optional_params.merge(initial_query_params).compact

    def validate_missing!(required_params, present_params)
      missing_required = required_params - present_params.keys
      return unless missing_required.any?

      raise ArgumentError,
            "missing keyword#{missing_required.length == 1 ? '' : 's'}: :#{missing_required.join(', :')}"
    end

    def validate_extra!(allowed_params, present_params)
      extra_params = present_params.keys - allowed_params
      return unless extra_params.any?

      raise ArgumentError,
            "unexpected keyword#{extra_params.length == 1 ? '' : 's'}: :#{extra_params.join(', :')}"
    end

    private

    def initialize(client)
      @client = client
    end

    def request(method, url: nil, **)
      url ||= derive_url_from_label caller_locations[1].label
      @client.send(method, url, **)
    end

    def derive_url_from_label(label)
      class_name, method = label.split.last.downcase.split '#' if label && !class_name && !method
      construct_url(class_name, method)
    end

    def construct_url(class_name, method)
      url_method = camelize(method.to_s).chomp '!'
      package = class_name_to_package class_name
      "/xrpc/#{package}.#{url_method}"
    end

    def class_name_to_package(class_name)
      class_name.downcase.gsub('::', '.').delete_prefix 'arroba.'
    end

    def camelize(non_camelized)
      first, *rest = non_camelized.split('_')
      [first, *rest.map(&:capitalize)].join
    end
  end
end
