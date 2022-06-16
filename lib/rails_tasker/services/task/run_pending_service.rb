# frozen_string_literal: true

require 'colorize'
require 'rails_tasker/services/task/fetch_pending_service'
require 'rails_tasker/serviceable'

module RailsTasker
  class Task
    class RunPendingService
      include Serviceable

      def call
        puts "Running pending tasks...\n".cyan
        pending_tasks.map do |task|
          puts(
            "Running Version: #{task.timestamp} Name: #{task.task_name}".magenta
          )
          print 'Output: '.green, task.call, "\n\n"
        end
        puts "Successfully ran #{pending_tasks.length} tasks...".green
      end

      private

      def pending_tasks
        @pending_tasks ||= FetchPendingService.call
      end
    end
  end
end
