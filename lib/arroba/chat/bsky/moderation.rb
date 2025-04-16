# frozen_string_literal: true

module Arroba
  class Chat
    class BSky
      class Moderation < BaseResource
        basic_get :get_actor_metadata, :actor
        basic_get :get_message_context, :message_id, convo_id: nil, before: nil,
                                                     after: nil do |convo_id:, **|
          if convo_id.nil?
            warn 'DEPRECATION WARNING: The `convo_id` parameter is not currently required, but will be in the ' \
                 'future. Please provide it to avoid breaking changes.'
          end
        end
        basic_post :update_actor_access, :actor, :allow_access, ref: nil
      end
    end
  end
end
