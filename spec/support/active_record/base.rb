# frozen_string_literal: true

module ActiveRecord
  class Base
    class << self
      attr_accessor :table_name
    end
  end
end
