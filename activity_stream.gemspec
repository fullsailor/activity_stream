# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "activity_stream/version"

Gem::Specification.new do |s|
  s.name        = "activity_stream"
  s.version     = ActivityStream::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Andrew Smith"]
  s.email       = ["andrew@envylabs.com"]
  s.homepage    = "http://rubygems.org/gems/activity_stream"
  s.summary     = %q{Rails plugin to add activity streams for your users}
  s.description = %q{Rails plugin to add activity streams for your users, highly opinionated.}

  s.rubyforge_project = "activity_stream"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency "rspec-rails", "~> 1.3.0"
  s.add_development_dependency "rails", "~> 2.3.10"
  s.add_development_dependency "capybara"
end
