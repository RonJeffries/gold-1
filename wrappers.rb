# wrapper classes

class OriginalWrapper

  NormalDegradation = 1

  def initialize(item)
    @item = item
  end

  def update
    return if sulfuras?
    decrement_sell_in
    case
      when brie?     then update_brie
      when ticket?  then update_ticket
      when conjured? then update_conjured
      else update_normal
    end
  end

  def update_normal
    decrement_quality_down_to_zero(NormalDegradation)
    decrement_quality_down_to_zero(NormalDegradation) if expired?
  end

  def brie?
    @item.name == "Aged Brie"
  end

  def update_brie
    increment_quality_up_to_50
    increment_quality_up_to_50 if expired?
  end

  def conjured?
    return @item.name.downcase.include? 'conjured'
  end

  def update_conjured
    double_degrade = 2*NormalDegradation
    decrement_quality_down_to_zero(double_degrade)
    decrement_quality_down_to_zero(double_degrade) if expired?
  end

  def sulfuras?
    @item.name == "Sulfuras, Hand of Ragnaros"
  end

  ## sulfurus does not update

  def ticket?
    @item.name == "Backstage passes to a TAFKAL80ETC concert"
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

  ## utility methods

  def decrement_quality_down_to_zero(increment)
    @item.quality -= increment
    @item.quality = 0 if @item.quality < 0
  end

  def decrement_sell_in
    @item.sell_in -= 1
  end

  def expired?
    @item.sell_in < 0
  end

  def increment_quality_up_to_50
      @item.quality += 1 unless @item.quality >= 50
  end

  def set_quality_zero
    @item.quality = 0
  end
end