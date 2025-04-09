# frozen_string_literal: true

require_relative 'bsky/actor'
require_relative 'bsky/feed'

module Arroba
  class BSky
    def initialize(client)
      @client = client
    end

    def actor = @actor ||= Actor.new(@client)

    def feed = @feed ||= Feed.new(@client)
  end
end
