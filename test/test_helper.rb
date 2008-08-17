$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'rubygems'
require 'test/unit'
require 'multi_rails_init'
require 'active_record' 
require 'active_record/fixtures'

require File.dirname(__FILE__) + '/../init.rb'

ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")

ActiveRecord::Base.configurations = YAML::load(IO.read(File.dirname(__FILE__) + "/db/database.yml"))
ActiveRecord::Base.establish_connection(ENV["DB"] || "sqlite3mem")
ActiveRecord::Migration.verbose = false
load(File.join(File.dirname(__FILE__), "db", "schema.rb"))

class Person < ActiveRecord::Base
  has_many :phones
end
class Phone < ActiveRecord::Base
  belongs_to :person
  set_inheritance_column false
end

class Test::Unit::TestCase #:nodoc:
  self.fixture_path = File.dirname(__FILE__) + "/fixtures/"
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  fixtures :all
end