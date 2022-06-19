# frozen_string_literal: true

require_relative 'lib/rails_tasker/version'

Gem::Specification.new do |gem|
  gem.name          = 'rails_tasker'
  gem.version       = RailsTasker::VERSION
  gem.authors       = ['Michael Wilmouth']
  gem.email         = ['wilmouthworks@gmail.com']

  gem.summary       = 'Automate your Rails after-deployment tasks with rails_tasker'
  gem.description   = gem.summary
  gem.homepage      = 'https://github.com/mawilmouth/rails_tasker'
  gem.license       = 'MIT'
  gem.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  gem.metadata['homepage_uri'] = gem.homepage
  gem.metadata['source_code_uri'] = 'https://github.com/mawilmouth/rails_tasker'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gem.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end

  gem.bindir        = 'exe'
  gem.executables   = gem.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_dependency 'colorize'
  
  gem.add_development_dependency 'rake', '~> 13.0'
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'timecop', '~> 0.9.5'
  gem.add_development_dependency 'rubocop', '~> 0.80'
  gem.add_development_dependency 'simplecov'
end
