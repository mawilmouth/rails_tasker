# frozen_string_literal: true

module Rails
  module Generators
    class Base
      class << self
        def source_root(_path); end
      end

      def template(_path_one, _path_two); end
    end
  end
end
