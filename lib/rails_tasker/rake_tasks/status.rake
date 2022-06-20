require 'rake'
require 'rails_tasker/services/task/status_service'

namespace :rails_tasker do
  desc 'Prints up/down status of all tasks'
  task :status => :environment do
    RailsTasker::Task::StatusService.call
  end
end
