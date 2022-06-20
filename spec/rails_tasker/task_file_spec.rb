# frozen_string_literal: true

require 'spec_helper'
require 'rails_tasker/task_file'
require 'rails_tasker/models/task'
require_relative '../../examples/lib/rails_tasker/tasks/1234_example_task'
require_relative '../../examples/lib/rails_tasker/tasks/12345_example_task'

RSpec.describe RailsTasker::TaskFile do
  let(:examples_path) { '../../examples/lib/rails_tasker/tasks' }
  let(:filename) { "#{examples_path}/1234_example_task.rb" }
  let(:instance) { described_class.new(filename: filename) }

  describe '#filename' do
    it 'returns the expected result' do
      expect(instance.filename).to eq filename
    end
  end

  describe '#timestamp' do
    it 'returns the expected result' do
      expect(instance.timestamp).to eq '1234'
    end
  end

  describe '#task_name' do
    it 'returns the expected result' do
      expect(instance.task_name).to eq 'example_task'
    end
  end

  describe '#pending?' do
    let(:is_completed) { false }

    before do
      allow(RailsTasker::Task).to receive(:completed_task?).and_return is_completed
    end

    it 'returns true' do
      expect(instance.pending?).to eq true
    end

    context 'timestamp is empty' do
      let(:filename) { "#{examples_path}/example_without_timestamp_task.rb" }

      it 'returns false' do
        expect(instance.pending?).to eq false
      end
    end

    context 'the task has been completed' do
      let(:is_completed) { true }

      it 'returns false' do
        expect(instance.pending?).to eq false
      end
    end
  end

  describe '#status' do
    let(:call) { instance.status }

    before { allow(instance).to receive(:pending?).and_return true }

    it 'returns the expected status' do
      expect(call).to eq described_class::DOWN_STATUS
    end

    context 'task is not pending' do
      before { allow(instance).to receive(:pending?).and_return false }

    it 'returns the expected status' do
      expect(call).to eq described_class::UP_STATUS
    end
    end
  end

  describe '#call' do
    before do
      allow(instance).to receive(:require).and_return true
      allow(ExampleTask).to receive(:call)
      allow(Object).to receive(:remove_const)
    end

    it 'requires the expected file' do
      instance.call
      expect(instance).to have_received(:require).with(filename).once
    end

    it 'calls the expected class' do
      instance.call
      expect(ExampleTask).to have_received(:call).with(no_args).once
    end

    it 'attempts to remove const to prevent name collisions' do
      instance.call
      expect(Object).to have_received(:remove_const).with(ExampleTask.to_s).once
    end

    context 'class cannot be found' do
      let(:file_name) { "#{examples_path}/12345_example_task.rb" }

      before { allow(ExampleTaskDuplicate).to receive(:call) }

      it 'does not call the task' do
        instance.call
        expect(ExampleTaskDuplicate).not_to have_received(:call)
      end
    end
  end
end
