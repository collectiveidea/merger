require 'rake'
require "load_multi_rails_rake_tasks" 
require 'rake/testtask'
require 'rake/rdoctask'
require 'rcov/rcovtask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

namespace :test do
  desc "just rcov minus html output"
  Rcov::RcovTask.new(:coverage) do |t|
    t.test_files = FileList['test/**/*_test.rb']
    t.output_dir = 'coverage'
    t.verbose = true
    t.rcov_opts = %w(--exclude test,/usr/lib/ruby,/Library/Ruby --sort coverage)
  end
end

desc 'Generate documentation for the plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Merger'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end