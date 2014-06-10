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

    def user_rated(value = nil)
      @items.select do |item|
        if value.kind_of? Range
          value.include? item.user_rating
        elsif value.kind_of? Integer
          item.user_rating == value
        elsif value.nil?
          !item.user_rating.nil?
        end
      end
    end

    private

    def parse
      @xml.xpath('items/item').map do |item|
        Bgg::Collection::Item.new item, @request
      end
    end
  end
end
