# frozen_string_literal: true

require 'spec_helper'
require 'rails_tasker/models/task'

RSpec.describe RailsTasker::Task do
  describe '#table_name' do
    it 'sets the expected table name' do
      expect(described_class.table_name).to eq 'rails_tasker_tasks'
    end
  end
end
