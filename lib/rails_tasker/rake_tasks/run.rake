require 'rake'
require 'rails_tasker/services/task/run_pending_service'
require 'rails_tasker/services/task/run_service'

namespace :rails_tasker do
  desc(
    'Runs all pending rails_tasker tasks ordered by the timestamp'\
    ' in their filename or a specific task by the timestamp passed'
  )
  task :run, %i[version] => :environment do |_task, args|
    if args.version.nil?
      RailsTasker::Task::RunPendingService.call
    else
      RailsTasker::Task::RunService.call(version: args.version)
    end
  end
end
