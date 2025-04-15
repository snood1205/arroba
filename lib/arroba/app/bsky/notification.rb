# frozen_string_literal: true

module Arroba
  class App
    class BSky
      class Notification < BaseResource
        get_with_query_params :get_unread_count, priority: nil, seen_at: nil
        get_with_query_params :list_notifications, reasons: nil, limit: nil, priority: nil, cursor: nil, seen_at: nil

        def put_preferences!(priority:)
          post body: { priority: }
        end

        # Add better validation for platform before release
        get_with_query_params :register_push, :service_did, :token, :platform, :app_id

        def update_seen!(seen_at:)
          post body: { seen_at: }
        end
      end
    end
  end
end
