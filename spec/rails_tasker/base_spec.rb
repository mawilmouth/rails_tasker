# frozen_string_literal: true

require 'spec_helper'
require 'rails_tasker/base'
require 'rails_tasker/serviceable'

RSpec.describe RailsTasker::Base do
  it 'includes Serviceable' do
    expect(described_class.ancestors).to include RailsTasker::Serviceable
  end
end
