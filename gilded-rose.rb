class GildedRose

  def initialize(items)
    @items = items
  end

  def match_name(item,name)
    return item.name.downcase.include? name.downcase
  end

  def conjured_degradation(item)
    normal_degradation = 1
    if item.sell_in < 0
      normal_degradation = 2*normal_degradation
    end
    conjured_degradation = 2*normal_degradation
  end

  def update_conjured_item(item)
    item.sell_in = item.sell_in - 1
    item.quality = [0,item.quality - conjured_degradation(item)].max
  end

  def update_item(item)
    if (match_name(item,"conjured"))
      update_conjured_item(item)
      return
    end
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1 #1 for sword
          end
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        if item.name == "Aged Brie"
          if item.quality < 50
            item.quality = item.quality + 1
          end
        elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
          item.quality = 0
        else
          if item.quality > 0
            if item.name != "Sulfuras, Hand of Ragnaros"
              item.quality = item.quality - 1
            end
          end
        end
      end  
  end

  def update_quality()
    @items.each do |item|
      update_item(item)
    end #do
  end #update_quality
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