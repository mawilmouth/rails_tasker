# frozen_string_literal: true

require 'rails_tasker/serviceable'
require 'rails_tasker/services/task/fetch_service'

module RailsTasker
  class Task
    class FetchPendingService
      include Serviceable

      def call
        pending_tasks
      end

      private

      def pending_tasks
        @pending_tasks ||= FetchService.call.select(&:pending?)
      end
    end
  end
end
