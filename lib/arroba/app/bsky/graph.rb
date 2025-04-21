# frozen_string_literal: true

module Arroba
  class App
    class BSky
      # The Graph resource provides access to the social graph of a user, including followers, follows, and blocks.
      class Graph < BaseResource
        include Validations::Limitable
        get_with_enforced_limit :get_actor_starter_packs, :actor
        get_with_enforced_limit :get_blocks
        get_with_enforced_limit :get_followers, :actor
        get_with_enforced_limit :get_follows, :actor
        get_with_enforced_limit :get_known_followers, :actor
        get_with_enforced_limit :get_list_blocks
        get_with_enforced_limit :get_list_mutes
        get_with_enforced_limit :get_list, :list
        get_with_enforced_limit :get_lists, :actor
        get_with_enforced_limit :get_mutes
        basic_get :get_relationships, :actor, others: [] do |others: [], **|
          enforce_limit! others.count, min: 0, max: 30, name: 'The length of array others'
        end
        basic_get :get_starter_pack, :starter_pack
        basic_get :get_starter_packs, :uris do |uris:, **|
          enforce_limit! uris.count, min: 0, max: 25, name: 'The length of array uris'
        end
        basic_get :get_suggested_follows_by_actor, :actor
        basic_post :mute_actor_list, :list
        basic_post :mute_actor, :actor
        basic_post :mute_thread, :root
        get_with_enforced_limit :search_starter_packs, :q
        basic_post :unmute_actor_list, :list
        basic_post :unmute_actor, :actor
        basic_post :unmute_thread, :root
      end
    end
  end
end
