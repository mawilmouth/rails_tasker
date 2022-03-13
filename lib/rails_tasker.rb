# frozen_string_literal: true

module RailsTasker  
  require_relative 'rails_tasker/railtie' if defined?(Rails::Railtie)

  def self.setup
    yield self
  end
end
