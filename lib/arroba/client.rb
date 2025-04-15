# frozen_string_literal: true

require_relative 'base_resource'
require_relative 'app'
require_relative 'http_client'

module Arroba
  # This class is the main entry point for the Arroba gem.
  # It provides a simple interface to interact with the Bluesky API.
  #
  # @example
  #    app = Arroba::Client.new(identifier: 'your_identifier', password: 'your_password')
  #    app.bsky.actor.get_profile(actor: 'example_handle')
  class Client
    attr_reader :app

    def initialize(identifier: nil, password: nil, base_url: 'https://bsky.social')
      raise ArgumentError, 'Both identifier and password are required' if identifier.nil? || password.nil?

      @client = HTTPClient.new(identifier:, password:, base_url:)
      @app = App.new(@client)
    end
  end
end
