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
    if !brie?(item) and !tickets?(item)
      if item.quality > 0
        if !sulfuras?(item)
          item.quality = item.quality - 1 #1 for sword
        end
      end
    elsif brie?(item)
      update_brie(item)
    elsif tickets?(item)
      update_ticket(item)
    end
    if !sulfuras?(item)
      item.sell_in = item.sell_in - 1
    end
    if expired?(item)
      if brie?(item)
        increment_quality_up_to_50(item)
      elsif tickets?(item)
        set_quality_zero(item)
      else
        if item.quality > 0
          if !sulfuras?(item)
            item.quality = item.quality - 1
          end
        end
      end
    end 
  end

  def sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def update_brie(item)
    increment_quality_up_to_50(item)
  end

  def update_ticket(item)
    increment_quality_up_to_50(item)
    if item.sell_in < 11
      increment_quality_up_to_50(item)
    end
    if item.sell_in < 6
      increment_quality_up_to_50(item)
    end
  end

  def tickets?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def brie?(item)
    item.name == "Aged Brie"
  end

  def set_quality_zero(item)
    item.quality = 0
  end

  def expired?(item)
    item.sell_in < 0
  end

  def increment_quality_up_to_50(item)
      item.quality += 1 unless item.quality >= 50
  end

end