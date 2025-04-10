# frozen_string_literal: true

require_relative '../validations'

module Arroba
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
    end
  end
end
