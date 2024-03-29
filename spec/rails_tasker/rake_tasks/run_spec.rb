# frozen_string_literal: true

require 'spec_helper'
require 'rails_tasker/services/task/run_pending_service'
require 'rails_tasker/services/task/run_service'
load 'rails_tasker/rake_tasks/run.rake'

RSpec.describe 'rails_tasker:run' do
  include_context 'rake task'

  before { allow(RailsTasker::Task::RunPendingService).to receive(:call) }

  it 'calls the expected service' do
    invoke
    expect(RailsTasker::Task::RunPendingService).to(
      have_received(:call).with(no_args).once
    )
  end

  context 'version is passed' do
    let(:args) { [1234] }

    before { allow(RailsTasker::Task::RunService).to receive(:call) }

    it 'calls the expected service' do
      invoke
      expect(RailsTasker::Task::RunService).to(
        have_received(:call).with(version: 1234).once
      )
    end
  end
end
