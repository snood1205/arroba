# frozen_string_literal: true

require_relative 'bsky/actor'
require_relative 'bsky/convo'
require_relative 'bsky/moderation'

module Arroba
  class Chat
    class BSky
      def initialize(client)
        @client = client
      end

      def actor = @actor ||= Actor.new(@client)
      def convo = @convo ||= Convo.new(@client)
      def moderation = @moderation ||= Moderation.new(@client)
    end
  end
end
