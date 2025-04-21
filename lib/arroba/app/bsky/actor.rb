# frozen_string_literal: true

module Arroba
  class App
    class BSky
      # The Actor resource provides access to user profiles and related data.
      class Actor < BaseResource
        include Validations::Limitable

        basic_get :get_preferences
        basic_get :get_profile, :actor
        basic_get :get_profiles, :actors
        basic_get :get_suggestions, limit: nil, &DEFAULT_LIMIT
        basic_get :search_actors, :q, limit: nil, with_auth: false, &DEFAULT_LIMIT
        basic_get :search_actors_typeahead, :q, limit: nil, with_auth: false, &DEFAULT_LIMIT
        basic_post :put_preferences, :preferences
      end
    end
  end
end
