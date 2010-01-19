require 'rake'
require "load_multi_rails_rake_tasks" 

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "merger"
    gem.summary = "A Rails plugin for merging Active Record models"
    gem.email = "brandon@opensoul.org"
    gem.homepage = "http://github.com/collectiveidea/merger"
    gem.authors = ["Brandon Keepers"]
    gem.add_dependency "activerecord"
    gem.add_development_dependency "mocha"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end


desc 'Default: run unit tests.'
task :default => :test

require 'rake/testtask'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib' << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

namespace :test do
  begin
    require 'rcov/rcovtask'
    Rcov::RcovTask.new(:coverage) do |test|
      test.libs << 'test'
      test.pattern = 'test/**/test_*.rb'
      test.verbose = true
      test.output_dir = 'coverage'
      test.rcov_opts = %w(--exclude test,/usr/lib/ruby,/Library/Ruby --sort coverage)
    end
  rescue LoadError
    task :coverage do
      abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
    end
  end
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "merger #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
  rdoc.options << '--line-numbers' << '--inline-source'
end

task :default => :test
task :test => :check_dependencies
