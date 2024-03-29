# frozen_string_literal: true

module RailsTasker
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'rails_tasker/rake_tasks/run.rake'
      load 'rails_tasker/rake_tasks/status.rake'
    end

    initializer 'load_task_record_models' do
      require 'rails_tasker/models/task'
    end

    generators do
      require 'rails_tasker/generators/install/install_generator'
      require 'rails_tasker/generators/task/task_generator'
    end
  end
end
