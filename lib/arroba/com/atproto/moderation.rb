# frozen_string_literal: true

module Arroba
  class Com
    class ATProto
      class Moderation < BaseResource
        basic_post :create_report, :reason_type, :subject, reason: nil
      end
    end
  end
end
