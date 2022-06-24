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

      def find_by(**args)
        all.find_by(**args)
      end

      def create!(**args)
        all.create!(**args)
      end

      def find_or_create_by!(**args)
        find_by(**args) || create!(**args)
      end
    end

    def initialize(**attributes)
      @record = OpenStruct.new(**attributes)
    end

    def to_h
      record.to_h
    end

    private

    attr_reader :record
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
      data.find { |record| record.to_h == args }
    end

    def create!(**args)
      data << Base.new(**args)
    end
  end
end
