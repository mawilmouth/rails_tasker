# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'
require 'colorize'
require 'rails_tasker/services/task/run_pending_service'
require 'rails_tasker/services/task/fetch_pending_service'
require 'rails_tasker/serviceable'

RSpec.describe RailsTasker::Task::RunPendingService do
  def create_task(output:, name:)
    OpenStruct.new(
      call: output,
      timestamp: frozen_time,
      task_name: name,
    )
  end

  it 'includes Serviceable' do
    expect(described_class.ancestors).to include RailsTasker::Serviceable
  end

  describe '#call' do
    let(:frozen_time) { Time.now.to_i }
    let(:task_one) do
      create_task output: 'task one result', name: 'task one'
    end
    let(:task_two) do
      create_task output: 'task two result', name: 'task two'
    end
    let(:tasks) { [task_one, task_two] }
    let(:instance) { described_class.new }
    let(:call) { instance.call }

    before do
      allow(instance).to receive(:puts)
      allow(instance).to receive(:print)
      allow(RailsTasker::Task::FetchPendingService).to(
        receive(:call).and_return tasks
      )
      tasks.each { |task| allow(task).to receive(:call).and_call_original }
    end

    it 'calls the expected tasks' do
      call
      tasks.each do |task|
        expect(task).to have_received(:call).with(no_args).once
      end
    end

    it 'prints information regarding running the tasks' do
      call
      expect(instance).to have_received(:puts).with(
        "Running pending tasks...\n".cyan
      ).once

      tasks.each do |task|
        expect(instance).to have_received(:puts).with(
          "Running Version: #{frozen_time} Name: #{task.task_name}".magenta
        ).once

        expect(instance).to have_received(:print).with(
          "Output: ".green, task.call, "\n\n"
        ).once
      end

      expect(instance).to have_received(:puts).with(
        "Successfully ran #{tasks.length} tasks...".green
      ).once
    end
  end
end
