# frozen_string_literal: true

module Arroba
  class Com
    class ATProto
      class Identity < BaseResource
        basic_get :get_recommended_did_credentials
        basic_post :refresh_identity, :identifier
      end
    end
  end
end
