# frozen_string_literal: true

require_relative '../validations'

module Arroba
  class BSky
    class Feed < BaseResource
      include Validations::Limitable
      # NOTE: it is described as not needing auth so with_auth is set to false, but it has given me 400 for that.
      # When setting with_auth to true, it has only 404'd for me
      get_with_query_params :describe_feed_generator, with_auth: false
      get_with_query_params :get_actor_feeds, :actor, limit: nil, cursor: nil, &DEFAULT_LIMIT
      get_with_query_params :get_actor_likes, :actor, limit: nil, cursor: nil, &DEFAULT_LIMIT
      get_with_query_params :get_author_feed, :actor, limit: nil, cursor: nil, filter: nil, include_pins: nil,
                            &DEFAULT_LIMIT
      get_with_query_params :get_feed_generator, :feed
      get_with_query_params :get_feed_generators, :feeds
      get_with_query_params :get_feed_skeleton, :feed, limit: nil, cursor: nil, &DEFAULT_LIMIT
      get_with_query_params :get_feed, :feed, limit: nil, cursor: nil, &DEFAULT_LIMIT
      get_with_query_params :get_likes, :uri, cid: nil, limit: nil, cursor: nil, &DEFAULT_LIMIT
      get_with_query_params :get_list_feed, :list, limit: nil, cursor: nil, &DEFAULT_LIMIT
      get_with_query_params :get_post_thread, :uri, depth: nil, parent_height: nil do
        enforce_limit! depth, min: 0, max: 1000, name: 'Depth'
        enforce_limit! parent_height, min: 0, max: 1000, name: 'Parent height'
      end
    end
  end
end
