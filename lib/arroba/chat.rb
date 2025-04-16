# frozen_string_literal: true

require_relative 'chat/bsky'

module Arroba
  class Chat
    attr_reader :bsky

    def initialize(client)
      @bsky = BSky.new(client)
    end
  end
end
