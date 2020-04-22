# wrapper classes

class ConjuredWrapper
  def initialize(item)
    @item = item
  end

  def conjured_degradation
    normal_degradation = 1
    if @item.sell_in < 0
      normal_degradation = 2*normal_degradation
    end
    conjured_degradation = 2*normal_degradation
    return conjured_degradation
  end

  def update
    item = @item
    item.sell_in = item.sell_in - 1
    item.quality = [0,item.quality - conjured_degradation].max
  end

end

class OriginalWrapper
  def initialize(item)
    @item = item
  end

  def update
    item = @item
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

end