# frozen_string_literal: true

module Arroba
  class App
    class BSky
      class Labeler < BaseResource
        basic_get :get_services, :dids, detailed: nil
      end
    end
  end
end
