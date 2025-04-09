# frozen_string_literal: true

require_relative 'bsky/actor'

module Arroba
  class BSky
    attr_reader :actor

    def initialize(client)
      @actor = Actor.new client
    end
  end
end
