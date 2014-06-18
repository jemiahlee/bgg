module Bgg
  class Hot
    include Bgg::Result::Container

    attr_reader :type

    def initialize(xml, request)
      super xml, request
      @type = request_params[:type] || 'boardgame'
    end
  end
end
