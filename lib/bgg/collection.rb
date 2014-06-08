module Bgg
  class Collection
    include Enumerable
    include Bgg::Result

    def initialize(xml, request)
      @xml = xml
      @request = request
      @items = parse
    end

    def each &block
      @items.each do |item|
        block.call item
      end
    end

    def owned
      @items.select { |item| item.owned? }
    end

    def played
      @items.select{ |item| item.played? }
    end

    private

    def parse
      @xml.xpath('items/item').map do |item|
        Bgg::Collection::Item.new item, @request
      end
    end
  end
end
