require 'merger/merge'

module Merger
  def self.included(base)
    base.send :include, InstanceMethods
  end
  
  module InstanceMethods
    def merge!(*others)
      Merger.new(others.push(self)).merge!
    end
  end
end