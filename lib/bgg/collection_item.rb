module Bgg
  class Collection
    class Item
      include Bgg::Result

      attr_reader :collection_id, :comment, :id, :image, :name,
                  :play_count, :thumbnail, :type, :year_published,
                  :players, :play_time, :own_count, :user_rating,
                  :average_rating, :bgg_rating, :type_rank, :theme_ranks,
                  :last_modified

      def initialize(item, request)
        # Integers
        @xml = item
        @request = request
        @id = xpath_value_int "@objectid"
        @collection_id = xpath_value_int "@collid"
        @play_count = xpath_value_int "numplays"
        @year_published = xpath_value_int "yearpublished"
        @play_time = xpath_value_int "stats/@playingtime"
        @own_count = xpath_value_int "stats/@numowned"
        @type_rank = xpath_value_int "stats/rating/ranks/rank[@type='subtype']/@value"

        # Floats
        @user_rating = xpath_value_float "stats/rating/@value"
        @average_rating = xpath_value_float "stats/rating/average/@value"
        @bgg_rating = xpath_value_float "stats/rating/bayesaverage/@value"

        # Range
        @players = xpath_value_range "stats/@minplayers", "stats/@maxplayers"

        # Strings
        @name = xpath_value "name"
        @type = xpath_value "@subtype"
        @image = xpath_value "image"
        @thumbnail = xpath_value "thumbnail"
        @comment = xpath_value "comment"

        # Booleans
        @owned = xpath_value_boolean "status/@own"
        @wanted = xpath_value_boolean "status/@want"
        @for_trade = xpath_value_boolean "status/@fortrade"
        @preordered = xpath_value_boolean "status/@preordered"
        @want_to_buy = xpath_value_boolean "status/@wanttobuy"
        @want_to_play = xpath_value_boolean "status/@wanttoplay"

        # Hashes
        @theme_ranks = xpath_value_ranks "stats/rating/ranks/rank[@type='family']"

        # Dates
        @last_modified = xpath_value_time "status/@lastmodified"
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

      private

      def xpath_value_range(start_path, end_path)
        min_players = xpath_value_int start_path
        max_players = xpath_value_int end_path
        (min_players and max_players) ?  min_players..max_players : nil
      end

      def xpath_value_time(path)
        time_string = xpath_value path
        Time.new(time_string) if time_string
      end

      def xpath_value_ranks(path)
        selected_ranks = @xml.xpath path
        selected_ranks.map do |rank|
          { id: xpath_value_int("@id", rank),
            title: xpath_value("@friendlyname", rank),
            rank: xpath_value_int("@value", rank),
            rating: xpath_value_float("@bayesaverage", rank) }
        end unless selected_ranks.empty?
      end
    end
  end
end

