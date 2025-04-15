# frozen_string_literal: true

module Arroba
  class App
    class BSky
      class Labeler < BaseResource
        get_with_query_params :get_services, :dids, detailed: nil
      end
    end
  end
end
