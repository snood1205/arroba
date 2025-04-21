# frozen_string_literal: true

module Arroba
  class Com
    class ATProto
      class Admin < BaseResource
        include Validations::Limitable
        basic_post :delete_account, :did
        basic_post :disable_account_invites, :account, note: nil
        basic_post :disable_invite_codes, codes: nil, accounts: nil
        basic_post :enable_account_invites, :account, note: nil
        basic_get :get_account_info, :did
        basic_get :get_account_infos, :dids
        get_with_enforced_limit :get_invite_codes, sort: nil, max: 500
        basic_get :get_subject_status, did: nil, uri: nil, blob: nil
        get_with_enforced_limit :search_accounts, email: nil
        basic_post :send_email, :recipient_did, :content, :sended_did, subject: nil, comment: nil
        basic_post :update_account_email, :account, :email
        basic_post :update_account_handle, :account, :handle
        basic_post :update_account_password, :account, :password
        basic_post :update_subject_status, :subject, takedown: nil, deactivated: nil
      end
    end
  end
end
