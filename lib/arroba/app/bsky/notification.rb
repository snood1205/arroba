# frozen_string_literal: true

module Arroba
  class App
    class BSky
      class Notification < BaseResource
        basic_get :get_unread_count, priority: nil, seen_at: nil
        basic_get :list_notifications, reasons: nil, limit: nil, priority: nil, cursor: nil, seen_at: nil
        basic_post :put_preferences, :priority
        # Add better validation for platform before release
        basic_get :register_push, :service_did, :token, :platform, :app_id
        basic_post :update_seen, :seen_at
      end
    end
  end
end
