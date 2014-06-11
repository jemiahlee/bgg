module Bgg
  class Hot
    include Enumerable
    include Bgg::Result
    attr_reader :type

    def initialize(xml, request)
      @xml = xml
      @request = request
      @items = parse
      @type = request_params[:type] || 'boardgame'
    end

    def each &block
      @items.each do |item|
        block.call item
      end
    end

    private

    def parse
      @xml.xpath('items/item').map do |item|
        Bgg::Hot::Item.new item, @request
      end
    end
  end
end
