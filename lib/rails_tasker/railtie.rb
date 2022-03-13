# frozen_string_literal: true

module RailsTasker
  class Railtie < Rails::Railtie
    generators do
      require_relative 'generators/install/install_generator.rb'
    end
  end
end
