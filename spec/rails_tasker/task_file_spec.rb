# frozen_string_literal: true

require 'spec_helper'
require 'rails_tasker/task_file'
require 'rails_tasker/models/task'

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
end
