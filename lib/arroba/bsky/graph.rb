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
      get_with_enforced_limit :get_list, list:
    end
  end
end
