# frozen_string_literal: true

require_relative 'atproto/admin'
require_relative 'atproto/identity'
require_relative 'atproto/label'
require_relative 'atproto/moderation'
require_relative 'atproto/repo'
require_relative 'atproto/server'
require_relative 'atproto/sync'

module Arroba
  class Com
    class ATProto
      def initialize(client)
        @client = client
      end

      def admin = @admin ||= Admin.new(@client)
    end
  end
end
