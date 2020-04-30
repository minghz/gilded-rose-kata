require File.join(File.dirname(__FILE__), 'gilded_rose')
#require 'test/unit'
require 'minitest/autorun'

#class TestUntitled < Test::Unit::TestCase
class TestUntitled < Minitest::Test

  describe 'normal items' do
    it 'degrades' do
      items = [Item.new(name="+5 Dexterity Vest", sell_in=10, quality=20)]
      GildedRose.new(items).update_quality()

      assert_equal items[0].name, "+5 Dexterity Vest"
      assert_equal items[0].sell_in, 9
      assert_equal items[0].quality, 19
    end

    it 'degrades twice as fast past sell date' do
      items = [Item.new(name="+5 Dexterity Vest", sell_in=0, quality=10)]
      GildedRose.new(items).update_quality()

      assert_equal items[0].name, "+5 Dexterity Vest"
      assert_equal items[0].sell_in, -1
      assert_equal items[0].quality, 8
    end

    it 'wont have negative quality' do
      items = [Item.new(name="+5 Dexterity Vest", sell_in=10, quality=0)]
      GildedRose.new(items).update_quality()

      assert_equal items[0].name, "+5 Dexterity Vest"
      assert_equal items[0].sell_in, 9
      assert_equal items[0].quality, 0
    end
  end

  describe 'aged brie' do
    it 'increases in quality the older it gets' do
      items = [Item.new(name="Aged Brie", sell_in=10, quality=0)]
      GildedRose.new(items).update_quality()

      assert_equal items[0].name, "Aged Brie"
      assert_equal items[0].sell_in, 9
      assert_equal items[0].quality, 1
    end 

    it 'quality wont increase beyond 50' do
      items = [Item.new(name="Aged Brie", sell_in=10, quality=50)]
      GildedRose.new(items).update_quality()

      assert_equal items[0].name, "Aged Brie"
      assert_equal items[0].sell_in, 9
      assert_equal items[0].quality, 50
    end 
  end

  describe 'legendary sulfuras' do
    it 'sell_in and quality dont change' do
      items = [Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=80)]
      GildedRose.new(items).update_quality()

      assert_equal items[0].name, "Sulfuras, Hand of Ragnaros"
      assert_equal items[0].sell_in, 0
      assert_equal items[0].quality, 80
    end
  end

  describe 'backstage passes' do
    it 'increases in quality by 1, 11 or more days before expiry' do
      items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20)]
      GildedRose.new(items).update_quality()

      assert_equal items[0].name, "Backstage passes to a TAFKAL80ETC concert"
      assert_equal items[0].sell_in, 14
      assert_equal items[0].quality, 21
    end

    it 'increases in quality by 2, between 6 and 10 days from expiry' do
      items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=20)]
      GildedRose.new(items).update_quality()

      assert_equal items[0].name, "Backstage passes to a TAFKAL80ETC concert"
      assert_equal items[0].sell_in, 9
      assert_equal items[0].quality, 22
    end

    it 'increases in quality by 3, when 5 or less days from expiry' do
      items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=5, quality=20)]
      GildedRose.new(items).update_quality()

      assert_equal items[0].name, "Backstage passes to a TAFKAL80ETC concert"
      assert_equal items[0].sell_in, 4
      assert_equal items[0].quality, 23
    end
  end

end
