module Bgg
  module Result
    module Container
      include Enumerable
      include Bgg::Result

      def initialize(xml, request)
        super xml, request
        @items = parse
      end

      def each &block
        @items.each do |item|
          block.call item
        end
      end

      private

      def parse
        @xml.xpath('items/item').map do |item|
          self.class::Item.new item, @request
        end
      end
    end
  end
end
