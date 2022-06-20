# frozen_string_literal: true

require 'spec_helper'
require 'rails_tasker/serviceable'
require 'rails_tasker/services/task/fetch_service'
require 'rails_tasker/services/task/fetch_pending_service'

RSpec.describe RailsTasker::Task::FetchPendingService do
  def create_task(pending:)
    instance_double('RailsTasker::TaskFile', pending?: pending)
  end

  let(:task_one) { create_task(pending: true) }
  let(:task_two) { create_task(pending: false) }
  let(:task_three) { create_task(pending: true) }
  let(:tasks) { [task_one, task_two, task_three] }

  before do
    allow(RailsTasker::Task::FetchService).to receive(:call).and_return tasks
  end

  it 'includes Serviceable' do
    expect(described_class.ancestors).to include RailsTasker::Serviceable
  end

  describe '#call' do
    let(:call) { described_class.call }

    it 'returns the expected task files' do
      expect(call).to eq [task_one, task_three]
    end

    it 'filters with the #pending? method' do
      call
      tasks.each do |task|
        expect(task).to have_received(:pending?).with(no_args).once
      end
    end
  end
end
