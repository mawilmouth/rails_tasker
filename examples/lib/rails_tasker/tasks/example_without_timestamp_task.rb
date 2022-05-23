# frozen_string_literal: true

require 'rails_tasker/base'

class ExampleWithoutTimeStampTask < RailsTasker::Base
  def call; end
end
