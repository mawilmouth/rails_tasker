# frozen_string_literal: true

RSpec.shared_context 'rake task', :shared_context => :metadata do
  let(:task_name) { self.class.top_level_description }
  let(:invoke) { Rake::Task[task_name].invoke }

  before { Rake::Task.define_task(:environment) }

  after(:each) { Rake::Task[task_name].reenable }
end
