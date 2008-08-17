require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class MergerTest < Test::Unit::TestCase

  def test_ar_responds_to_merge!
    assert People.respond_to?(:merge!)
  end

end