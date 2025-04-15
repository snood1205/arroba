# frozen_string_literal: true

module Arroba
  class App
    class BSky
      class Video < BaseResource
        get_with_query_params :get_job_status, :job_id
        basic_get :get_upload_limits

        def upload_video!(mp4_blob:)
          post body: mp4_blob
        end
      end
    end
  end
end
