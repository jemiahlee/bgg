module Bgg
  class Link
    attr_reader :id, :bgg_type, :value
    def initialize(link_data = {})
      @game_data = link_data
      @id = link_data['id'].to_i
      @value = link_data['value']
      @bgg_type = adj_type(link_data['type'])
    end

    def self.import_from(link_data_hashes)
      link_data_hashes.map{|ld| self.new(ld)}
    end

    private

    def adj_type(str)
      str.gsub(/^boardgame/,'')
    end
  end
end
