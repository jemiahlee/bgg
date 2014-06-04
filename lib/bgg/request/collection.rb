module Bgg
  module Request
    class Collection < Base

      def self.request(username, params = {})
        if username.nil? || username.empty?
          raise ArgumentError.new("missing required username")
        else
          params[:username] = username
        end

        super(:collection, params)
      end

    end
  end
end
