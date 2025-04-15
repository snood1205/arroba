# frozen_string_literal: true

module Arroba
  class BSky
    class Notification < BaseResource
      get_with_query_params :get_unread_count, priority: nil, seen_at: nil
      get_with_query_params :list_notifications, reasons: nil, limit: nil, priority: nil, cursor: nil, seen_at: nil
    end
  end
end
