# frozen_string_literal: true

require 'rails_tasker/models/task'

module RailsTasker
  module Generators
    class TaskGenerator < Rails::Generators::Base
      source_root(File.expand_path('../templates', __FILE__))
      argument(:name, type: :string)

      def create_task_file
        template(
          'task.erb',
          "lib/rails_tasker/tasks/#{timestamp}_#{task_name}.rb"
        )
      end

      private

      def timestamp
        @timestamp ||= Time.now.utc.strftime('%Y%m%d%H%M%S')
      end

      def task_name
        @task_name ||= name.downcase
      end

      def task_name_pascal
        @task_name_pascal ||= task_name.split('_').map(&:capitalize).join
      end
    end
  end
end