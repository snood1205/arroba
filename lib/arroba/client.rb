# frozen_string_literal: true

require_relative 'base_resource'
require_relative 'app'
require_relative 'chat'
require_relative 'http_client'

module Arroba
  # This class is the main entry point for the Arroba gem.
  # It provides a simple interface to interact with the Bluesky API.
  #
  # @example
  #    app = Arroba::Client.new(identifier: 'your_identifier', password: 'your_password')
  #    app.bsky.actor.get_profile(actor: 'example_handle')
  class Client
    def initialize(identifier: nil, password: nil, auth_url: 'https://bsky.social')
      raise ArgumentError, 'Both identifier and password are required' if identifier.nil? || password.nil?

      @client = HTTPClient.new(identifier:, password:, auth_url:)
    end

    def app = @app ||= App.new(@client)

    def chat
      return @chat unless @chat.nil?

      @client.proxy_for_chat!
      @chat = Chat.new(@client)
    end
  end
end
