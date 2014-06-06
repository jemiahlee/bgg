module Bgg
  class Collection
    include Enumerable
    include Bgg::Result

    def initialize(request)
      @xml = request.get
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
        Bgg::Collection::Item.new item
      end
    end
  end
end
