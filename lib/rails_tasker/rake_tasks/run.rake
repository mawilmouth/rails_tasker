require 'rake'
require 'rails_tasker/services/task/run_pending_service'

namespace :rails_tasker do
  desc 'Runs all pending rails_tasker tasks ordered by the timestamp in their filename.'
  task :run => :environment do
    RailsTasker::Task::RunPendingService.call
  end
end
