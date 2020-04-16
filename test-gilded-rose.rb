require "./gilded-rose"
require "minitest/autorun"

class TestGildedRose<Minitest::Test
  
  def test_hookup
    assert true
  end

  def test_foo
    items = [Item.new("foo", 0, 0)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].name, "foo"
  end

end