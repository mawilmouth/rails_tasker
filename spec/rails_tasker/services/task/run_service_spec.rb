# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'
require 'colorize'
require 'rails_tasker/services/task/run_service'
require 'rails_tasker/services/task/fetch_service'
require 'rails_tasker/serviceable'

RSpec.describe RailsTasker::Task::RunService do
  def create_task(output:, name:)
    OpenStruct.new(
      call: output,
      timestamp: Time.now.to_i + rand(1..100),
      task_name: name,
    )
  end

  it 'includes Serviceable' do
    expect(described_class.ancestors).to include RailsTasker::Serviceable
  end

  describe '#call' do
    let(:task_one) do
      create_task output: 'task one result', name: 'task one'
    end
    let(:task_two) do
      create_task output: 'task two result', name: 'task two'
    end
    let(:tasks) { [task_one, task_two] }
    let(:instance) { described_class.new }
    let(:version) { task_two.timestamp }
    let(:call) { instance.call(version: version) }

    before do
      allow(instance).to receive(:puts)
      allow(instance).to receive(:print)
      allow(RailsTasker::Task::FetchService).to receive(:call).and_return(tasks)
      tasks.each { |task| allow(task).to receive(:call).and_call_original }
    end

    it 'calls the expected task' do
      call
      expect(task_one).not_to have_received(:call)
      expect(task_two).to have_received(:call).with(no_args).once
    end

    it 'prints information regarding running the tasks' do
      call
      expect(instance).to have_received(:puts).with(
        "Running Version: #{task_two.timestamp} Name: #{task_two.task_name}".magenta
      ).once

      expect(instance).to have_received(:print).with(
        "Output: ".green, task_two.call, "\n\n"
      ).once
    end

    context 'task with timestamp cannot be found' do
      let(:version) { 23434523 }

      it 'does not call a task' do
        call
        expect(task_one).not_to have_received(:call)
        expect(task_two).not_to have_received(:call)
      end
  
      it 'prints information regarding running the tasks' do
        call
        expect(instance).to have_received(:puts).with(
          "Task with version: #{version} cannot be found...".magenta
        ).once
      end
    end
  end
end
