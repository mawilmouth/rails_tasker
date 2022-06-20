# frozen_string_literal: true

require 'spec_helper'
require 'rails_tasker/services/task/fetch_pending_service'
require 'rails_tasker/serviceable'
require 'rails_tasker/task_file'

RSpec.describe RailsTasker::Task::FetchPendingService do
  before do
    stub_const(
      "RailsTasker::Task::FILE_LOCATION",
      'examples/lib/rails_tasker/tasks/*.rb',
    )
  end

  it 'includes Serviceable' do
    expect(described_class.ancestors).to include RailsTasker::Serviceable
  end

  describe '#call' do
    let(:call) { described_class.call }

    it 'returns the expected number of files' do
      expect(call.length).to eq 3
    end

    it 'returns task files' do
      expect(call).to all be_a RailsTasker::TaskFile
    end

    it 'returns the sorted task files' do
      expect(call.map(&:timestamp)).to eq %w[3 1234 12345]
    end
  end
end
