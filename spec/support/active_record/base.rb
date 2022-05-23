# frozen_string_literal: true

require 'ostruct'

module ActiveRecord
  class Base
    class << self
      attr_accessor :table_name
      
      def all
        Collection.new(all_result || [])
      end

      def all_result
        []
      end
    end
  end

  class Collection
    def initialize(data = [])
      @data = data
    end

    attr_accessor :data

    def [](index)
      data[index]
    end

    def []=(index, value)
      data[index] = value
    end

    def find_by(**args)
      args.each do |key, value|
        if data.find { |v| v == value }
          return OpenStruct.new(key => value)
        end
      end

      nil
    end
  end
end
