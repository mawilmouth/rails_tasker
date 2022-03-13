# frozen_string_literal: true

require 'rails_tasker/models/task'

module RailsTasker
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def create_initializer_file
        template 'rails_tasker.erb', 'config/initializers/rails_tasker.rb'
      end

      def copy_migration
        template 'migration.erb', "db/migrate/#{timestamp}_create_#{table_name}.rb"
      end

      private

      def timestamp
        @timestamp ||= Time.now.utc.strftime('%Y%m%d%H%M%S')
      end

      def rails_version_for_migration
        "#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}"
      end

      def table_name
        RailsTasker::Task.table_name
      end
    end
  end
end