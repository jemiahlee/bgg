module Bgg
  class Collection
    include Enumerable
    include Bgg::Result

    def self.board_games(username, params = {})
      Bgg::Collection.new username, params.merge!(Bgg::Request::Collection::BOARD_GAMES)
    end

    def self.board_game_expansions(username, params = {})
      Bgg::Collection.new username, params.merge!(Bgg::Request::Collection::BOARD_GAME_EXPANSIONS)
    end

    def self.rpgs(username, params = {})
      Bgg::Collection.new username, params.merge!(Bgg::Request::Collection::RPGS)
    end

    def self.video_games(username, params = {})
      Bgg::Collection.new username, params.merge!(Bgg::Request::Collection::VIDEO_GAMES)
    end

    def initialize(username, params = {})
      @xml = Bgg::Request::Collection.request username, params
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
