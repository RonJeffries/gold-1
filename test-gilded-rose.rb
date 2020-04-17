require "./gilded-rose"
require "minitest/autorun"

class TestGildedRose<Minitest::Test
  
  def test_hookup
    assert true
  end

  def test_foo
    items = [Item.new("foo", 0, 0)]
    GildedRose.new(items).update_quality()
    assert_equal "foo", items[0].name
  end

  def test_conjured
    gr = GildedRose.new([])
    item = Item.new("Conjured thing", sell_in=3, quality=10)
    gr.update_item(item)
    assert_equal(2, item.sell_in)
    assert_equal(8, item.quality)
  end

  def test_conjured_quality_non_negative
    gr = GildedRose.new([])
    item = Item.new("low-value conjured item", sell_in=2, quality=2)
    gr.update_item(item)
    assert_equal(1, item.sell_in)
    assert_equal(0, item.quality)
    gr.update_item(item)
    assert_equal(0, item.sell_in)
    assert_equal(0, item.quality)
  end


end