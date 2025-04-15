# frozen_string_literal: true

require_relative '../validations'

module Arroba
  class BSky
    # The Graph resource provides access to the social graph of a user, including followers, follows, and blocks.
    class Graph < BaseResource
      include Validations::Limitable
      # Document the dynamically defined method as a placeholder
      #
      # @method get_actor_starter_packs
      # This method is defined dynamically.
      # @return [Integer] The result of the addition (always 6 in this case).
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
      get_with_query_params :get_relationships, :actor, others: [] do |others: [], **|
        enforce_limit! others.count, min: 0, max: 30, name: 'The length of array others'
      end
      get_with_query_params :get_starter_pack, :starter_pack
      get_with_query_params :get_starter_packs, :uris do |uris:, **|
        enforce_limit! uris.count, min: 0, max: 25, name: 'The length of array uris'
      end
      get_with_query_params :get_suggested_follows_by_actor, :actor

      def mute_actor_list!(list:) = post body: { list: }
      def mute_actor!(actor:) = post body: { actor: }
      def mute_thread!(root:) = post body: { root: }

      get_with_enforced_limit :search_starter_packs, :q

      def unmute_actor_list!(list:) = post body: { list: }
      def unmute_actor!(actor:) = post body: { actor: }
      def unmute_thread!(root:) = post body: { root: }
    end
  end
end
