# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RailsTasker do
  describe '#setup' do
    it 'yields itself' do
      expect { |block| described_class.setup(&block) }.to(
        yield_with_args described_class
      )
    end
  end
end
