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
      request = Object.const_get("Bgg").const_get("Request").const_get(method.to_s.capitalize).new *params
      request.get
    end
  end
end

require 'bgg/request/base'
require 'bgg/request/collection'

require 'bgg/result'

require 'bgg/collection'
require 'bgg/collection_item'
