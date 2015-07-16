module Bgg
  class Game
    attr_reader :alternate_names, :artists, :categories,
                :description, :designers, :families, :id,
                :image, :max_players, :mechanics, :min_players,
                :name, :names, :playing_time, :publishers,
                :recommended_minimum_age, :thumbnail,
                :year_published, :stats

    def initialize(game_data)
      @game_data = game_data

      @id    = game_data['id'].to_i
      @names = game_data['name'].map { |n| n['value'] }
      @name  = game_data['name'].find { |n| n.fetch('type', '') == 'primary' }['value']

      @alternate_names         = @names.reject { |name| name == @name }
      @artists                 = filter_links_for('boardgameartist')
      @categories              = filter_links_for('boardgamecategory')
      @description             = game_data['description'][0]
      @designers               = filter_links_for('boardgamedesigner')
      @families                = filter_links_for('boardgamefamily')
      @image                   = game_data['image'][0]
      @max_players             = game_data['maxplayers'][0]['value'].to_i
      @mechanics               = filter_links_for('boardgamemechanic')
      @min_players             = game_data['minplayers'][0]['value'].to_i
      @playing_time            = game_data['playingtime'][0]['value'].to_i
      @publishers              = filter_links_for('boardgamepublisher')
      @recommended_minimum_age = game_data['minage'][0]['value'].to_i
      @thumbnail               = game_data['thumbnail'][0]
      @year_published          = game_data['yearpublished'][0]['value'].to_i
      @stats                   = parse_stats_from game_data['statistics']
    end

    def bgg_links
      @bgg_links ||= Link.import_from(@game_data['link'])
    end

    def self.find_by_id(game_id, opts = {})
      game_id = Integer(game_id)
      if game_id < 1
        raise ArgumentError.new('game_id must be greater than 0!')
      end
      opts[:id] = game_id
      opts[:type] = 'boardgame'
      game_data = BggApi.thing(opts)
      unless game_data.has_key?('item')
        raise ArgumentError.new('Game does not exist')
      end
      game_data = game_data['item'][0]

      Game.new(game_data)
    end

    private

    def filter_links_for(key)
      @game_data['link'].
          find_all { |l| l.fetch('type', '') == key }.
          map { |l| l['value'] }
    end

    def parse_stats_from(stats_data)
      return nil unless has_stats_to_parse?(stats_data)
      Bgg::Stats.new(stats_data.first['ratings'].first)
    end

    def has_stats_to_parse?(stats_data)

      stats_data &&
          stats_data.respond_to?(:first) &&
          stats_data.first.respond_to?(:fetch) &&
          stats_data.first['ratings'] &&
          stats_data.first['ratings'].respond_to?(:first)
    end


  end
end
