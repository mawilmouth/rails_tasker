# frozen_string_literal: true

require 'spec_helper'
require 'timecop'
require 'rails_tasker/generators/task/task_generator'

RSpec.describe RailsTasker::Generators::TaskGenerator do
  def stub_name
    allow(new_instance).to receive(:name).and_return name
  end

  let(:new_instance) { described_class.new }
  let(:name) { 'fake_task_name' }

  before { allow(new_instance).to receive(:template) }
 
  it 'expects an argument' do
    expect(new_instance.name).to eq 'fake argument value'
  end

  describe '#create_task_file' do
    before do
      Timecop.freeze(Time.now)
      stub_name
    end

    after { Timecop.return }

    it 'attempts to load the expected template and assigns expected path' do
      timestamp = Time.now.utc.strftime('%Y%m%d%H%M%S')
      new_instance.create_task_file
      expect(new_instance).to have_received(:template).with(
        'task.erb', "lib/rails_tasker/tasks/#{timestamp}_#{name}.rb"
      ).once
    end
  end

  describe 'private helpers' do
    describe '#task_name_pascal' do
      before { stub_name }

      it 'returns the task name in pascal case' do
        expect(new_instance.send(:task_name_pascal)).to eq 'FakeTaskName'
      end
    end
  end
end
