module Bgg
  class Stats

    attr_reader :average, :averageweight, :bayesaverage, :median, :stddev,
                :numcomments, :numweights, :owned, :trading, :usersrated,
                :wanting, :wishing, :ranks

    def initialize(stats_data)
      @average       = dec_val_from stats_data['average']
      @averageweight = dec_val_from stats_data['averageweight']
      @bayesaverage  = dec_val_from stats_data['bayesaverage']
      @median        = dec_val_from stats_data['median']
      @stddev        = dec_val_from stats_data['stddev']

      @numcomments = int_val_from stats_data['numcomments']
      @numweights  = int_val_from stats_data['numweights']
      @owned       = int_val_from stats_data['owned']
      @trading     = int_val_from stats_data['trading']
      @usersrated  = int_val_from stats_data['usersrated']
      @wanting     = int_val_from stats_data['wanting']
      @wishing     = int_val_from stats_data['wishing']

      @ranks = parse_ranks_from stats_data['ranks']
    end

    private

    def int_val_from(raw)
      raw.first['value'].to_i
    end

    def dec_val_from(raw)
      BigDecimal.new raw.first['value']
    end

    def parse_ranks_from(raw_ranks)
      return [] unless has_ranks_to_parse?(raw_ranks)
      raw_ranks.first['rank'].map {|rank_data| Bgg::GameRank.new(rank_data)}
    end

    def has_ranks_to_parse?(raw_ranks)

      raw_ranks &&
          raw_ranks.respond_to?(:first) &&
          raw_ranks.first.respond_to?(:fetch) &&
          raw_ranks.first['rank'] &&
          raw_ranks.first['rank'].respond_to?(:map)
    end
  end
end
