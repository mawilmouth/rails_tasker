# frozen_string_literal: true

module Rails
  module Generators
    class Base
      class << self
        def source_root(_path); end

        def argument(name, **_args)
          attr_reader(name)
          
          define_method :initialize do
            instance_variable_set("@#{name}", 'fake argument value')
          end
        end
      end

      def template(_path_one, _path_two); end
    end
  end
end
