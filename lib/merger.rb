require 'merger/merge'

module Merger
  def self.included(base)
    base.send :include, InstanceMethods
  end
  
  module InstanceMethods
    def merge!(*others)
      Merger::Merge.new(others, :keep => self).merge!
    end
  end
end