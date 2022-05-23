# frozen_string_literal: true

require 'spec_helper'
require 'rails_tasker/models/task'

RSpec.describe RailsTasker::Task do
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

  describe '#completed_task?' do
    let(:call) { described_class.completed_task?(version: 1234) }

    context 'the record exists' do
      before do
        allow(described_class).to receive(:all_result).and_return([5678, 1234])
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
end
