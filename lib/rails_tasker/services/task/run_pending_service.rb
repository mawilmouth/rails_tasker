# frozen_string_literal: true

require 'rails_tasker/services/task/fetch_pending_service'
require 'rails_tasker/serviceable'

module RailsTasker
  class Task
    class RunPendingService
      include Serviceable

      def call
        pending_tasks.map(&:call).length
      end

      private

      def pending_tasks
        @pending_tasks ||= FetchPendingService.call.to_a
      end
    end
  end
end
