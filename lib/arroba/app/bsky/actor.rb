# frozen_string_literal: true

require_relative '../../validations'

module Arroba
  class App
    class BSky
      # The Actor resource provides access to user profiles and related data.
      class Actor < BaseResource
        include Validations::Limitable

        basic_get :get_preferences
        get_with_query_params :get_profile, :actor
        get_with_query_params :get_profiles, :actors
        get_with_query_params :get_suggestions, limit: nil, &DEFAULT_LIMIT
        get_with_query_params :search_actors, :q, limit: nil, with_auth: false, &DEFAULT_LIMIT
        get_with_query_params :search_actors_typeahead, :q, limit: nil, with_auth: false, &DEFAULT_LIMIT
        basic_post :put_preferences, :preferences
      end
    end
  end
end
