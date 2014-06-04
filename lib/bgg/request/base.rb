require 'httparty'
require 'nokogiri'

module Bgg
  module Request
    class Base
      include HTTParty

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

      def self.request(method, params = {})
        raise ArgumentError.new('unknown request method') unless METHODS.include? method

        url = BASE_URI + '/' + method.to_s
        response = self.get(url, query: params)

        if response.code == 200
          xml_data = response.body
          Nokogiri.XML(xml_data)
        else
          raise "Received a #{response.code} at #{url} with #{params}"
        end
      end

    end
  end
end
