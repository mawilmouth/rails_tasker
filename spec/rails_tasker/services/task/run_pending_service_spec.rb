# frozen_string_literal: true

require 'spec_helper'
require 'rails_tasker/services/task/run_pending_service'
require 'rails_tasker/services/task/fetch_pending_service'
require 'rails_tasker/serviceable'

RSpec.describe RailsTasker::Task::RunPendingService do
  def create_task
    Class.new do
      include RailsTasker::Serviceable

      def call
        true
      end
    end
  end

  it 'includes Serviceable' do
    expect(described_class.ancestors).to include RailsTasker::Serviceable
  end

  describe '#call' do
    let(:task_one) { create_task }
    let(:task_two) { create_task }
    let(:task_three) { create_task }
    let(:tasks) { [task_one, task_two, task_three] }
    let(:call) { described_class.call }

    before do
      allow(RailsTasker::Task::FetchPendingService).to(
        receive(:call).and_return tasks
      )
      tasks.each { |task| allow(task).to receive(:call) }
    end

    it 'calls the expected tasks' do
      call
      tasks.each do |task|
        expect(task).to have_received(:call).with(no_args).once
      end
    end

    it 'returns the expected number of called tasks' do
      expect(call).to eq tasks.length
    end
  end
end
