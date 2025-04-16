# frozen_string_literal: true

require_relative '../../validations'

module Arroba
  class Chat
    class BSky
      class Convo < BaseResource
        include Validations::Limitable
        basic_post :accept_convo, :convo_id
        basic_post :delete_message_for_self, :convo_id, :message_id
        basic_get :get_convo_availability, :members
        basic_get :get_convo_for_members, :members
        basic_get :get_convo, :convo_id
        basic_get :get_log, cursor: nil
        get_with_enforced_limit :get_messages, :convo_id
        basic_post :leave_convo, :convo_id
        get_with_enforced_limit :list_convos, read_state: nil, status: nil
        basic_post :mute_convo, :convo_id
        basic_post :send_message_batch, :items
        basic_post :send_message, :convo_id, :message
        basic_post :unmute_convo, :convo_id
        basic_post :update_all_read, :status
        basic_post :update_read, :convo_id, :message_id
      end
    end
  end
end
