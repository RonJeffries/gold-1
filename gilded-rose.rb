# Gilded Rose

require "./wrappers"

class GildedRose

  def initialize(items)
    @items = items
  end

  def match_name(item,name)
    return item.name.downcase.include? name.downcase
  end

  def update_item(item)
    OriginalWrapper.new(item).update
  end

  def update_quality()
    @items.each do |item|
      update_item(item)
    end
  end
end # Gilded_Rose

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end