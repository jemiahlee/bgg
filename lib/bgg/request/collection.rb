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

      def self.board_games(username, params = {})
        request = Bgg::Request::Collection.new username, params.merge!(BOARD_GAMES)
        request.get
      end

      def self.board_game_expansions(username, params = {})
        request = Bgg::Request::Collection.new username, params.merge!(BOARD_GAME_EXPANSIONS)
        request.get
      end

      def self.rpgs(username, params = {})
        request = Bgg::Request::Collection.new username, params.merge!(RPGS)
        request.get
      end

      def self.video_games(username, params = {})
        request = Bgg::Request::Collection.new username, params.merge!(VIDEO_GAMES)
        request.get
      end

      def initialize(username, params = {})
        if username.nil? || username.empty?
          raise ArgumentError.new "missing required username"
        else
          params[:username] = username
        end

        super :collection, params
      end

    end
  end
end
