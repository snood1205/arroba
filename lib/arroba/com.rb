# frozen_string_literal: true

require_relative 'com/atproto'

module Arroba
  class Com
    attr_reader :atproto

    def initialize(client)
      @atproto = ATProto.new(client)
    end
  end
end
