class BggRequest

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
    :user,
  ].freeze

  METHODS.each do |method|
    define_singleton_method method do |*params|
      request = Object::const_get("Bgg::Request::#{method.to_s.capitalize}").new *params
      Object::const_get("Bgg::#{method.to_s.capitalize}").new request
    end
  end
end

require 'bgg/request/base'
require 'bgg/request/collection'

require 'bgg/result'

require 'bgg/collection'
require 'bgg/collection_item'
