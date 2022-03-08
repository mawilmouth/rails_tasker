# frozen_string_literal: true

require_relative 'lib/rails/tasker/version'

Gem::Specification.new do |spec|
  spec.name          = 'rails-tasker'
  spec.version       = Rails::Tasker::VERSION
  spec.authors       = ['Michael Wilmouth']
  spec.email         = ['wilmouthworks@gmail.com']

  spec.summary       = 'Automate your Rails after-deployment tasks with rails-tasker'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/mawilmouth/rails-tasker'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/mawilmouth/rails-tasker'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.80'
end
