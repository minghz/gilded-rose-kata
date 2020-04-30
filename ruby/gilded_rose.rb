class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|

      if item.name == 'Aged Brie'
        AgedBrie.age(item)
      elsif item.name == 'Sulfuras, Hand of Ragnaros'
        Sulfuras.age(item)
      elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
        BackstagePass.age(item)
      else

        if item.quality > 0
          item.quality = item.quality - 1
        end

        item.sell_in = item.sell_in - 1

        if item.sell_in < 0

          if item.quality > 0
            item.quality = item.quality - 1
          end

        end
      end
    end
  end
end

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

module AgedBrie
  def self.age(item)
    if item.quality < 50
      item.quality = item.quality + 1
    end

    item.sell_in = item.sell_in - 1
  end
end

module Sulfuras
  def self.age(item)
    # nothing happens
  end
end

module BackstagePass
  def self.age(item)
    if item.quality < 50
      case item.sell_in
      when (11..100) then item.quality = item.quality + 1
      when (6..10) then item.quality = item.quality + 2
      when (1..5) then item.quality = item.quality + 3
      when (-100..0) then item.quality = 0
      end
    end

    item.sell_in = item.sell_in - 1
  end
end
