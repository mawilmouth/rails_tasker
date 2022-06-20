# frozen_string_literal: true

require 'spec_helper'
require 'rails_tasker/services/task/fetch_service'
load 'rails_tasker/rake_tasks/status.rake'

RSpec.describe 'rails_tasker:status' do
  include_context 'rake task'

  before { allow(RailsTasker::Task::FetchService).to receive(:call) }

  it 'calls the expected service' do
    invoke
    expect(RailsTasker::Task::FetchService).to(
      have_received(:call).with(no_args).once
    )
  end
end
