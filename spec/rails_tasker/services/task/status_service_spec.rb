# frozen_string_literal: true

require 'spec_helper'
require 'rails_tasker/serviceable'
require 'rails_tasker/services/task/fetch_service'
require 'rails_tasker/services/task/status_service'

RSpec.describe RailsTasker::Task::StatusService do
  it 'includes Serviceable' do
    expect(described_class.ancestors).to include RailsTasker::Serviceable
  end

  describe '#call' do
    let(:instance) { described_class.new }
    let(:call) { instance.call }
    let(:tasks) { ['task one', 'task two'] }

    before do
      allow(instance).to receive(:tp)
      allow(RailsTasker::Task::FetchService).to receive(:call).and_return tasks
    end

    it 'calls uses the FetchService' do
      call
      expect(RailsTasker::Task::FetchService).to(
        have_received(:call).with(no_args).once
      )
    end

    it 'uses table_print to print that status table' do
      call
      expect(instance).to(
        have_received(:tp).with(tasks, *described_class::COLUMNS).once
      )
    end
  end
end
