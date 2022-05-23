# frozen_string_literal: true

module RailsTasker
  module Serviceable
    def self.included(klass)
      klass.extend ClassMethods
    end

    def call
      raise NotImplementedError
    end

    module ClassMethods
      def call
        new.call
      end
    end
  end
end
