# frozen_string_literal: true

module RailsTasker
  class Task < ActiveRecord::Base
    self.table_name = 'rails_tasker_tasks'

    FILE_LOCATION = File.join(Rails.root, 'lib/rails_tasker/tasks/*.rb')

    def self.completed_task?(version:)
      !find_by(version: version).nil?
    end

    def self.complete!(version:)
      find_or_create_by!(version: version)
    end
  end
end
