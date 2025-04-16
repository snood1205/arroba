# frozen_string_literal: true

module Arroba
  class Chat
    class BSky
      class Actor < BaseResource
        basic_post :delete_account
        basic_get :export_account_data
      end
    end
  end
end
