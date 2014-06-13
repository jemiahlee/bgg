require 'httparty'
require 'xmlsimple'

# http://boardgamegeek.com/wiki/page/BGG_XML_API2#

class BggApi
  include HTTParty

  METHODS = [
    :family,
    :forum,
    :forumlist,
    :guild,
    :plays,
    :thing,
    :thread,
    :user,
  ].freeze

  BASE_URI = 'http://www.boardgamegeek.com/xmlapi2'
  OLD_URI  = 'http://www.boardgamegeek.com/xmlapi'

  METHODS.each do |method|
    define_singleton_method(method) do |params|
      params ||= {}

      url = BASE_URI + '/' + method.to_s
      response = self.get(url, :query => params)

      if response.code == 200
        xml_data = response.body
        XmlSimple.xml_in(xml_data)
      else
        raise "Received a #{response.code} at #{url} with #{params}"
      end
    end
  end
end


require 'bgg_request'
require 'bgg/game'
require 'bgg/plays'
require 'bgg/user'
