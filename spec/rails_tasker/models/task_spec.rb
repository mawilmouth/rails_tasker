# frozen_string_literal: true

require 'spec_helper'
require 'rails_tasker/models/task'

RSpec.describe RailsTasker::Task do
  def create_task(version)
    described_class.new(version: version)
  end

  describe 'FILE_LOCATION' do
    it 'returns the expected file path' do
      expect(described_class::FILE_LOCATION).to(
        eq './lib/rails_tasker/tasks/*.rb'
      )
    end
  end
  
  describe '#table_name' do
    it 'sets the expected table name' do
      expect(described_class.table_name).to eq 'rails_tasker_tasks'
    end
  end

  describe '.completed_task?' do
    let(:records) { [create_task(5678), create_task(1234)] }
    let(:call) { described_class.completed_task?(version: 1234) }

    context 'the record exists' do
      before do
        allow(described_class).to receive(:all_result).and_return(records)
      end

      it 'returns true' do
        expect(call).to eq true
      end
    end

    context 'the record does not exist' do
      it 'returns false' do
        expect(call).to eq false
      end
    end
  end

  describe '.complete!' do
    let(:call) { described_class.complete!(version: 1234) }

    before do
      allow(described_class).to(
        receive(:find_or_create_by!).and_return('fake record')
      )
    end

    it 'uses finds or creates the record' do
      call
      expect(described_class).to(
        have_received(:find_or_create_by!).with(version: 1234).once
      )
    end

    it 'returns the expected result' do
      expect(call).to eq 'fake record'
    end
  end
end
