require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake'
require 'spec/rake/spectask'

desc "Run all examples"
Spec::Rake::SpecTask.new('rspec') do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end