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
    @item.sell_in = @item.sell_in - 1
    @item.quality = [0,@item.quality - conjured_degradation].max
  end

end

class OriginalWrapper
  def initialize(item)
    @item = item
  end

  def update
    return if sulfuras?
    @item.sell_in = @item.sell_in - 1
    if brie?
      update_brie
    elsif tickets?
      update_ticket
    else
      decrement_quality_down_to_zero
      decrement_quality_down_to_zero if expired?
    end
  end

  def decrement_quality_down_to_zero
    @item.quality = @item.quality - 1 if @item.quality > 0
  end

  def sulfuras?
    @item.name == "Sulfuras, Hand of Ragnaros"
  end

  def update_brie
    increment_quality_up_to_50
    increment_quality_up_to_50 if expired?
  end

  def update_ticket
    increment_quality_up_to_50
    if @item.sell_in < 10
      increment_quality_up_to_50
    end
    if @item.sell_in < 5
      increment_quality_up_to_50
    end
    set_quality_zero if expired?
  end

  def tickets?
    @item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def brie?
    @item.name == "Aged Brie"
  end

  def set_quality_zero
    @item.quality = 0
  end

  def expired?
    @item.sell_in < 0
  end

  def increment_quality_up_to_50
      @item.quality += 1 unless @item.quality >= 50
  end

end