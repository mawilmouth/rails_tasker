# frozen_string_literal: true

require 'colorize'
require 'rails_tasker/services/task/fetch_service'
require 'rails_tasker/serviceable'

module RailsTasker
  class Task
    class RunService
      include Serviceable

      def call(version:)
        @version = version

        if task.nil?
          puts "Task with version: #{version} cannot be found...".magenta
          return
        else
          puts(
            "Running Version: #{task.timestamp} Name: #{task.task_name}".magenta
          )
          print 'Output: '.green, task.call, "\n\n"
        end
      end

      private

      attr_reader :version

      def task
        @task ||= FetchService.call.find { |task| task.timestamp == version }
      end
    end
  end
end
