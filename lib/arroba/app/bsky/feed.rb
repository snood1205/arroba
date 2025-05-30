# frozen_string_literal: true

module Arroba
  class App
    class BSky
      # The Feed resource provides access to posts, likes, reposts, and other
      class Feed < BaseResource
        include Validations::Limitable
        # NOTE: it is described as not needing auth so with_auth is set to false, but it has given me 400 for that.
        # When setting with_auth to true, it has only 404'd for me
        basic_get :describe_feed_generator, with_auth: false
        get_with_enforced_limit :get_actor_feeds, :actor
        get_with_enforced_limit :get_actor_likes, :actor
        get_with_enforced_limit :get_author_feed, :actor, filter: nil, include_pins: nil, with_auth: false
        basic_get :get_feed_generator, :feed
        basic_get :get_feed_generators, :feeds
        get_with_enforced_limit :get_feed_skeleton, :feed, with_auth: false
        get_with_enforced_limit :get_feed, :feed
        get_with_enforced_limit :get_likes, :uri, cid: nil
        get_with_enforced_limit :get_list_feed, :list, with_auth: false
        basic_get :get_post_thread, :uri, depth: nil, parent_height: nil,
                                          with_auth: false do |depth: nil, parent_height: nil, **|
          enforce_limit! depth, min: 0, max: 1000, name: 'Depth'
          enforce_limit! parent_height, min: 0, max: 1000, name: 'Parent height'
        end
        basic_get :get_posts, :uris do |uris:, **|
          raise ArgumentError, 'URI list must be 25 or fewer items' if uris.count > 25
        end
        get_with_enforced_limit :get_quotes, :uri, cid: nil
        get_with_enforced_limit :get_reposted_by, :uri, cid: nil
        get_with_enforced_limit :get_suggested_feeds
        get_with_enforced_limit :get_timeline, algorithm: nil
        get_with_enforced_limit :search_posts, :q, sort: nil, since: nil, until: nil, mentions: nil, author: nil,
                                                   lang: nil, domain: nil, url: nil,
                                                   tag: nil do |sort: nil, tag: nil, **|
          raise ArgumentError, 'sort must be "top" or "latest"' if !sort.nil? && sort != 'top' && sort != 'latest'
          raise ArgumentError, 'tag elements must be shorter than 640 characters' if tag&.any? { |t| t.length > 640 }
        end
        basic_post :send_interactions, :interactions
      end
    end
  end
end
