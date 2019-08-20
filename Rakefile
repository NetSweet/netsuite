#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :spec

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.pattern = './spec/**/*_spec.rb'
end

desc 'Generate code coverage'
RSpec::Core::RakeTask.new(:coverage) do |t|
  t.rcov = true
  t.rcov_opts = ['--exclude', '/gems/,spec']
end

# Don't push the gem to rubygems
ENV["gem_push"] = "false" # Utilizes feature in bundler 1.3.0

# Let bundler's release task do its job, minus the push to Rubygems,
# and after it completes, use "gem inabox" to publish the gem to our
# internal gem server.
Rake::Task["release"].enhance do
  spec = Gem::Specification::load(Dir.glob("*.gemspec").first)
  sh "gem inabox pkg/#{spec.name}-#{spec.version}.gem"
end
