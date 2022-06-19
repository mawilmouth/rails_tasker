# frozen_string_literal: true

require 'spec_helper'
require 'rails_tasker/services/task/run_pending_service'
load 'rails_tasker/rake_tasks/run.rake'

RSpec.describe 'rails_tasker:run' do
  let(:task_name) { self.class.top_level_description }
  let(:call) { Rake::Task[task_name].invoke }

  before { Rake::Task.define_task(:environment) }

  after(:each) { Rake::Task[task_name].reenable }

  before { allow(RailsTasker::Task::RunPendingService).to receive(:call) }

  it 'calls the expected service' do
    call
    expect(RailsTasker::Task::RunPendingService).to(
      have_received(:call).with(no_args).once
    )
  end
end
