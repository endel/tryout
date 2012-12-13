$: << 'lib'

require 'rake'
require 'bundler/setup'
require 'tryout'

require "rspec/core/rake_task"

desc "Run all specs"
task :spec => ["spec:all"]

desc "Run unit specs"
RSpec::Core::RakeTask.new(:'spec:all') do |t|
  t.rspec_opts = ['--colour']
  t.pattern = 'spec/**/*_spec.rb'
end

task :default => :spec

