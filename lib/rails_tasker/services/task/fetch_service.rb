# frozen_string_literal: true

require 'rails_tasker/models/task'
require 'rails_tasker/task_file'
require 'rails_tasker/serviceable'

module RailsTasker
  class Task
    class FetchService
      include Serviceable

      def call
        Dir[Task::FILE_LOCATION].map do |filename|
          TaskFile.new(filename: filename)
        end.select do |task|
          !task.timestamp.empty?
        end.sort_by { |task| task.timestamp.to_i }
      end
    end
  end
end
