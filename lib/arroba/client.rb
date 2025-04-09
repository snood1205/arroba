# frozen_string_literal: true

require_relative 'bsky'
require_relative 'http_client'

module Arroba
  class Client
    attr_reader :bsky

    def initialize(identifier: nil, password: nil, base_url: 'https://bsky.social')
      raise ArgumentError, 'Both identifier and password are required' if identifier.nil? || password.nil?

      @client = HTTPClient.new(identifier:, password:, base_url:)
      @bsky = BSky.new(@client)
    end
  end
end
