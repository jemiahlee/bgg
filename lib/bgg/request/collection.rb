module Bgg
  module Request
    class Collection < Base

      BOARD_GAMES = {
        subtype: "boardgame",
        excludesubtype: "boardgameexpansion"
      }
      BOARD_GAME_EXPANSIONS = { subtype: "boardgameexpansion" }
      RPGS = { subtype: "rpgitem" }
      VIDEO_GAMES = { subtype: "videogame" }

      def self.request(username, params = {})
        if username.nil? || username.empty?
          raise ArgumentError.new("missing required username")
        else
          params[:username] = username
        end

        super(:collection, params)
      end

    end
  end
end
