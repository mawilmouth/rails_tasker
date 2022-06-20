# frozen_string_literal: true

require 'table_print'
require 'rails_tasker/serviceable'
require 'rails_tasker/services/task/fetch_service'

module RailsTasker
  class Task
    class StatusService
      COLUMNS = %w[status timestamp task_name].freeze

      include Serviceable

      def call
        tp(tasks, *COLUMNS)
      end

      private

      def tasks
        @tasks ||= FetchService.call
      end
    end
  end
end
