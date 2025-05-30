# frozen_string_literal: true

module Arroba
  class Com
    class ATProto
      class Identity < BaseResource
        basic_get :get_recommended_did_credentials
        basic_post :refresh_identity, :identifier
        basic_post :request_plc_operation_signature
        basic_get :resolve_did, :did
        basic_get :resolve_handle, :handle
        basic_get :resolve_identity, :identifier
        basic_post :sign_plc_operation, token: nil, rotation_keys: nil, also_known_as: nil, verification_methods: nil,
                                        services: nil
        basic_post :submit_plc_operation, :operation
        basic_post :update_handle, :handle
      end
    end
  end
end
