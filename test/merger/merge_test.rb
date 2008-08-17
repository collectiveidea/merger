require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class Merger::MergeTest < Test::Unit::TestCase

  def setup
    @merge = Merger::Merge.new(people(:original), people(:duplicate))
  end

  def test_keeps_oldest_record
    assert_equal people(:original), @merge.keep
  end

  def test_uses_newer_as_duplicates
    assert @merge.duplicates.include?(people(:duplicate))
    assert !@merge.duplicates.include?(people(:original))
  end
  
  def test_merge_associations_moves_to_original
    @merge.associations!
    assert_equal 3, people(:original).phones.count
  end
  
end