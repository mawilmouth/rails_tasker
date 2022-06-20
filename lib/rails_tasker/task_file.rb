# frozen_string_literal: true

require 'rails_tasker/models/task'
require 'rails_tasker/base'

module RailsTasker
  class TaskFile
    UP_STATUS   = 'up'.freeze 
    DOWN_STATUS = 'down'.freeze

    def initialize(filename: '')
      @filename = filename
      @timestamp, @task_name = parse_filename
    end

    attr_reader :filename, :timestamp, :task_name

    def pending?
      @is_pending ||= !timestamp.empty? && !Task.completed_task?(
        version: timestamp
      )
    end

    def status
      pending? ? DOWN_STATUS : UP_STATUS
    end

    def call
      load_object
      output = nil

      unless task_klass.nil?
        output = task_klass.call
        unload_object
      end

      output
    end

    private

    def load_object
      require(filename)
    end

    def unload_object
      ::Object.send(:remove_const, task_klass.to_s)
    end

    def task_klass_name
      @task_klass_name ||= task_name.split('_').map(&:capitalize).join
    end

    def task_klass
      @task_klass ||= task_klass_name.empty? ?
        nil : ::Object.const_get(task_klass_name)
    end

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
