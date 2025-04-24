# frozen_string_literal: true

require_relative 'base_resource'
require_relative 'app'
require_relative 'chat'
require_relative 'com'
require_relative 'http_client'

module Arroba
  # This class is the main entry point for the Arroba gem.
  # It provides a simple interface to interact with the Bluesky API.
  # pds_url is optional and if provided is only used for com.atproto.* and not app.bsky.* or chat.bsky.* requests,
  # this could change in future versions.
  #
  # @example
  #    app = Arroba::Client.new(identifier: 'your_identifier', password: 'your_password')
  #    app.bsky.actor.get_profile(actor: 'example_handle')
  class Client
    def initialize(identifier: nil, password: nil, auth_url: 'https://bsky.social', pds_url: nil)
      raise ArgumentError, 'Both identifier and password are required' if identifier.nil? || password.nil?

      @pds_url = pds_url
      @client = HTTPClient.new(identifier:, password:, auth_url:)
    end

    def app = @app ||= App.new(@client)

    def chat
      return @chat unless @chat.nil?

      @client.proxy_for_chat!
      @chat = Chat.new(@client)
    end

    def com = @com ||= Com.new(pds_client)

    private

    def pds_client
      return @client if @pds_url.nil?
      return @pds_client if @pds_client

      @pds_client ||= @client.pds_client_with_url @pds_url
    end
  end
end
