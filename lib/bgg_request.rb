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
    define_singleton_method(method) do |params|
    end
  end
end

require 'bgg/request/base'
