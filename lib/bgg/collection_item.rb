module Bgg
  class Collection
    class Item
      include Bgg::Result

      attr_reader :collection_id, :comment, :id, :image, :name,
                  :play_count, :thumbnail, :type, :year_published

      def initialize(item)
        # Integers
        @xml = item
        @id = xpath_value_int "@objectid"
        @collection_id = xpath_value_int "@collid"
        @play_count = xpath_value_int "numplays"
        @year_published = xpath_value_int "yearpublished"

        # Strings
        @name = xpath_value "name"
        @type = xpath_value "@subtype"
        @image = xpath_value "image"
        @thumbnail = xpath_value "thumbnail"
        @comment = xpath_value "comment"

        # booleans
        @owned = xpath_value_boolean "status/@own"
        @wanted = xpath_value_boolean "status/@want"
        @for_trade = xpath_value_boolean "status/@fortrade"
        @preordered = xpath_value_boolean "status/@preordered"
        @want_to_buy = xpath_value_boolean "status/@wanttobuy"
        @want_to_play = xpath_value_boolean "status/@wanttoplay"
      end

      def played?
        @play_count > 0 if @play_count
      end

      def wanted?
        @wanted
      end

      def for_trade?
        @for_trade
      end

      def owned?
        @owned
      end

      def want_to_play?
        @want_to_play
      end

      def want_to_buy?
        @want_to_buy
      end

      def preordered?
        @preordered
      end

      def published?
        @year_published != 0 and @year_published <= Time.now.year if @year_published
      end

      #def game
        #Bgg::Game.find_by_id(self.id)
      #end
    end
  end
end

