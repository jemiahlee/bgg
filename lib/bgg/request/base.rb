require 'httparty'
require 'nokogiri'

module Bgg
  module Request
    class Base
      include HTTParty

      attr_reader :params

      METHODS = [
        :collection,
        :family,
        :forum,
        :forumlist,
        :guild,
        :hot,
        :plays,
        :search,
        :thing,
        :thread,
        :user
      ].freeze

      BASE_URI = 'http://www.boardgamegeek.com/xmlapi2'

      def initialize(method, params = {})
        raise ArgumentError.new 'unknown request method' unless METHODS.include? method

        @method = method
        @params = params
      end

      def get
        url = BASE_URI + '/' + @method.to_s
        response = self.class.get url, query: @params

        if response.code == 200
          xml_data = response.body
          Nokogiri.XML xml_data
        else
          raise "Received a #{response.code} at #{url} with #{@params}"
        end
      end

    end
  end
end
