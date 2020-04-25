require "./gilded-rose"
require "minitest/autorun"

class TestGildedRose<Minitest::Test

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

  def test_conjured_sell_in_negative
    gr = GildedRose.new([])
    item = Item.new("another conjured item", sell_in=0, quality=2)
    gr.update_item(item)
    assert_equal(-1, item.sell_in)
  end

  def test_conjured_double_dip_past_sell_in
    gr = GildedRose.new([])
    item = Item.new("double-dip conjured item", sell_in=0, quality=10)
    gr.update_item(item)
    assert_equal(6, item.quality)
  end

  def test_brie_quality_increases_to_50
    gr = GildedRose.new([])
    brie = Item.new("Aged Brie", sell_in=0, quality=49)
    gr.update_item(brie)
    assert_equal(50, brie.quality)
    gr.update_item(brie)
    assert_equal(50, brie.quality)
  end

end