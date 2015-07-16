module Bgg
  class GameRank
    attr_reader :type, :id, :name, :friendlyname, :value, :bayesaverage

    def initialize(stats_data)
      @type         = stats_data["type"]
      @id           = stats_data["id"].to_i
      @name         = stats_data["name"]
      @friendlyname = stats_data["friendlyname"]
      @value        = stats_data["value"].to_i
      @bayesaverage = BigDecimal.new(stats_data["bayesaverage"])
    end
  end
end
