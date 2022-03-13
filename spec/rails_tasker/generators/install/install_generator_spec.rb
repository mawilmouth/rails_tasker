# frozen_string_literal: true

require 'spec_helper'
require 'timecop'
require 'rails_tasker/generators/install/install_generator'

RSpec.describe RailsTasker::Generators::InstallGenerator do
  let(:new_instance) { described_class.new }

  before { allow(new_instance).to receive(:template) }

  describe '#create_initializer_file' do
    it 'attempts to load the expected template and assigns expected path' do
      new_instance.create_initializer_file
      expect(new_instance).to have_received(:template).with(
        'rails_tasker.erb', 'config/initializers/rails_tasker.rb'
      ).once
    end
  end

  describe '#copy_migration' do
    before { Timecop.freeze(Time.now) }

    after { Timecop.return }

    it 'attempts to load the expected template and assigns expected path' do
      timestamp = Time.now.utc.strftime('%Y%m%d%H%M%S')
      new_instance.copy_migration
      expect(new_instance).to have_received(:template).with(
        'migration.erb', "db/migrate/#{timestamp}_create_rails_tasker_tasks.rb"
      ).once
    end
  end
end
