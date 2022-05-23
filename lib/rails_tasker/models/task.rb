# frozen_string_literal: true

module RailsTasker
  class Task < ActiveRecord::Base
    self.table_name = 'rails_tasker_tasks'

    FILE_LOCATION = File.join(Rails.root, 'lib/rails_tasker/tasks/*.rb')

    def self.completed_task?(version:)
      !all.find_by(version: version).nil?
    end
  end
end
