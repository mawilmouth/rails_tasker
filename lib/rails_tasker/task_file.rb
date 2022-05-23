# frozen_string_literal: true

require 'rails_tasker/models/task'

module RailsTasker
  class TaskFile
    def initialize(filename: '')
      @filename = filename
      @timestamp, @task_name = parse_filename
    end

    attr_reader :filename, :timestamp, :task_name

    def pending?
      !timestamp.empty? && !Task.completed_task?(version: timestamp)
    end

    private

    def parse_filename
      timestamp = ''
      task_name = ''

      /(\d+)_(.+)\.rb/.match(Pathname(@filename).basename.to_s) do |m|
        timestamp = m[1]
        task_name = m[2]
      end

      [timestamp, task_name]
    end
  end
end
