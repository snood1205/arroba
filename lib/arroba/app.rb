# frozen_string_literal: true

require_relative 'app/bsky'

module Arroba
  class App
    attr_reader :bsky

    def initialize(client)
      @bsky = BSky.new(client)
    end
  end
end
