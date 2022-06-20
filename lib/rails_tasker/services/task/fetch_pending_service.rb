# frozen_string_literal: true

require 'rails_tasker/models/task'
require 'rails_tasker/task_file'
require 'rails_tasker/serviceable'

module RailsTasker
  class Task
    class FetchPendingService
      include Serviceable

      def call
        pending_tasks
      end

      private

      def pending_tasks
        @pending_tasks ||= Dir[Task::FILE_LOCATION].map do |filename|
          TaskFile.new(filename: filename)
        end.select(&:pending?).sort_by do |task|
          task.timestamp.to_i
        end
      end
    end
  end
end
