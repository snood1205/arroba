# frozen_string_literal: true

module Arroba
  class BSky
    class Actor
      def initialize(client)
        @client = client
      end

      def get_preferences
        @client.get '/xrpc/app.bsky.actor.getPreferences'
      end

      def get_profile(actor:)
        @client.get '/xrpc/app.bsky.actor.getProfile', query_params: { actor: }
      end

      def get_profiles(actors:)
        @client.get '/xrpc/app.bsky.actor.getProfiles', query_params: { actors: }
      end

      def get_suggestions(limit: nil)
        if limit && (limit < 1 || limit > 100)
          raise ArgumentError,
                'Limit must be an integer between 1 and 100, inclusive'
        end

        query_params = limit ? { limit: } : nil
        get '/xrpc/app.bsky.actor.getSuggestions', query_params:
      end

      def put_preferences!(preferences:)
        post '/xrpc/app.bsky.actor.putPreferences', body: { preferences: }
      end
    end
  end
end
