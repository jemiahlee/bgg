module Bgg
  class Search
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

    def board_games
      @items.select{ |item| item.type == 'boardgame' }
    end

    def board_game_expansions
      @items.select{ |item| item.type == 'boardgameexpansion' }
    end

    def rpg_issues
      @items.select{ |item| item.type == 'rpgissue' }
    end

    def rpg_items
      @items.select{ |item| item.type == 'rpgitem' }
    end

    def rpg_periodicals
      @items.select{ |item| item.type == 'rpgperiodical' }
    end

    def rpgs
      @items.select{ |item| item.type == 'rpg' }
    end

    def video_games
      @items.select{ |item| item.type == 'videogame' }
    end

    private

    def parse
      @xml.xpath('items/item').map do |item|
        Bgg::Search::Item.new item, @request
      end
    end
  end
end
