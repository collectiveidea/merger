require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class Merger::MergeTest < Test::Unit::TestCase

  def setup
    @merge = Merger::Merge.new(people(:original), people(:duplicate))
  end

  def test_keeps_oldest_record
    assert_equal people(:original), @merge.keep
  end
  
  def test_explicitly_specify_record_to_keep
    @merge = Merger::Merge.new(Person.find(:all), :keep => people(:duplicate))
    assert_equal people(:duplicate), @merge.keep
  end

  def test_uses_newer_as_duplicates
    assert @merge.duplicates.include?(people(:duplicate))
    assert !@merge.duplicates.include?(people(:original))
  end
  
  def test_moves_associations_to_original
    @merge.associations!
    assert_equal 3, people(:original).phones.count
    assert_equal 0, people(:duplicate).phones.count
  end
  
  def test_skip_association
    Merger::Merge.new(people(:original), people(:duplicate), :skip_association => :phones).merge!
    assert_equal 2, people(:original).phones.count
  end

  def test_merge_join_model

    duplicated_tags = [
      tags(:original_friend),
      tags(:dup_friend1),
      tags(:dup_friend2)
    ]

    Merger::Merge.new(duplicated_tags, :keep => tags(:original_friend)).merge!

    assert_equal 2, people(:original).tags.count
    assert_equal true, people(:original).tags.include?(tags(:original_friend))
    assert_equal true, people(:original).tags.include?(tags(:developer))
  
  end

  def test_merge_belongs_to
    Merger::Merge.new( phones(:duplicate_mobile), :keep => phones(:original_work) ).merge!
    
    assert people(:original).phones.include?( phones(:original_work) )
    assert !people(:original).phones.include?( phones(:duplicate_mobile) )
    
    assert_equal people(:original), phones(:original_work).person
    assert_equal 0, people(:duplicate).phones.count, people(:duplicate).phones.inspect
  end
  
  def test_merge_model_with_single_table_inheritance
    @merge.associations!
    assert_equal 6, people(:original).companies.count
    assert_equal 3, people(:original).clients.count
    assert_equal 3, people(:original).suppliers.count
    assert_equal 0, people(:duplicate).companies.count
  end
  
  def test_destroy_duplicates
    @merge.merge!
    assert_nil Person.find_by_id(people(:duplicate).id)
  end
  
  def test_no_destroy_option
    Merger::Merge.new(people(:original), people(:duplicate), :destroy => false).merge!
    assert_not_nil Person.find_by_id(people(:duplicate).id)
  end
  
  def test_merged_with_callback
    people(:duplicate).expects(:merged_with).with(people(:original))
    @merge.merge!
  end
end