# frozen_string_literal: true

module Arroba
  class Chat
    class BSky
      class Actor < BaseResource
        basic_post :delete_account
        basic_get :export_account_data
        basic_post :accept_convo, :convo_id
        basic_post :delete_message_for_self, :convo_id, :message_id
      end
    end
  end
end
