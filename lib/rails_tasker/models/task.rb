# frozen_string_literal: true

module RailsTasker
  class Task < ActiveRecord::Base
    self.table_name = 'rails_tasker_tasks'
  end
end
