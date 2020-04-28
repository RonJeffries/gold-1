#test-gided-rose.rb

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

  def test_past_due_brie_increases_by_1
    gr = GildedRose.new([])
    brie = Item.new("Aged Brie", sell_in=0, quality=40)
    gr.update_item(brie)
    assert_equal(42, brie.quality)
  end

  def test_ticket_does_not_increase_on_day_10_but_after_10
    gr = GildedRose.new([])
    tick = Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in=11, quality=40)
    gr.update_item(tick)
    assert_equal(10, tick.sell_in)
    assert_equal(41, tick.quality)
    gr.update_item(tick)
    assert_equal( 9, tick.sell_in)
    assert_equal(43, tick.quality)
  end

  def test_ticket_does_not_increase_on_day_5_but_after_5
    gr = GildedRose.new([])
    tick = Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in=6, quality=40)
    gr.update_item(tick)
    assert_equal(5, tick.sell_in)
    assert_equal(42, tick.quality)
    gr.update_item(tick)
    assert_equal( 4, tick.sell_in)
    assert_equal(45, tick.quality)
  end

  def test_text
    expected = "-------- day 0 --------
name, sellIn, quality
+5 Dexterity Vest, 10, 20
Aged Brie, 2, 0
Elixir of the Mongoose, 5, 7
Sulfuras, Hand of Ragnaros, 0, 80
Sulfuras, Hand of Ragnaros, -1, 80
Backstage passes to a TAFKAL80ETC concert, 15, 20
Backstage passes to a TAFKAL80ETC concert, 10, 49
Backstage passes to a TAFKAL80ETC concert, 5, 49
Conjured Mana Cake, 3, 6
Conjured Voodoo Doll, 0, 1
+1 Sword: Assbiter, 0, 20
conjured double dipper, 0, 10

-------- day 1 --------
name, sellIn, quality
+5 Dexterity Vest, 9, 19
Aged Brie, 1, 1
Elixir of the Mongoose, 4, 6
Sulfuras, Hand of Ragnaros, 0, 80
Sulfuras, Hand of Ragnaros, -1, 80
Backstage passes to a TAFKAL80ETC concert, 14, 21
Backstage passes to a TAFKAL80ETC concert, 9, 50
Backstage passes to a TAFKAL80ETC concert, 4, 50
Conjured Mana Cake, 2, 4
Conjured Voodoo Doll, -1, 0
+1 Sword: Assbiter, -1, 18
conjured double dipper, -1, 6

"

    items = [
      Item.new(name="+5 Dexterity Vest", sell_in=10, quality=20),
      Item.new(name="Aged Brie", sell_in=2, quality=0),
      Item.new(name="Elixir of the Mongoose", sell_in=5, quality=7),
      Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=80),
      Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=-1, quality=80),
      Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20),
      Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=49),
      Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=5, quality=49),
      # This Conjured item does not work properly yet
      Item.new(name="Conjured Mana Cake", sell_in=3, quality=6),
      Item.new(name="Conjured Voodoo Doll", sell_in=0, quality=1),
      Item.new(name="+1 Sword: Assbiter", sell_in=0, quality=20),
      Item.new(name="conjured double dipper", sell_in=0, quality = 10)
    ]

    days = 2
    # if ARGV.size > 0
    #   days = ARGV[0].to_i + 1
    # end

    actual = StringIO.new
    gilded_rose = GildedRose.new items
    (0...days).each do |day|
      actual.puts "-------- day #{day} --------"
      actual.puts "name, sellIn, quality"
      items.each do |item|
        actual.puts item
      end
      actual.puts ""
      gilded_rose.update_quality
    end

    assert_equal(expected, actual.string)
    # if actual.string != expected
    #   puts actual.string
    # end
  end

end