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
    it 'returns the expected number of files' do
      expect(described_class.call.length).to eq 2
    end

    it 'returns task files' do
      expect(described_class.call).to all be_a RailsTasker::TaskFile
    end
  end
end
