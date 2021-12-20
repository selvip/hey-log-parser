# frozen_string_literal: true

module Hey
  module Log
    module Parser
      #  Rubocop note: WebLog acts as object of each log
      class WebLog
        attr_reader :visitors, :path, :count

        def initialize(ip:, path:)
          @visitors = { ip.to_s => 1 }
          @path = path
          @count = 1
        end

        def add_count(ip)
          ip_to_s = ip.to_s
          if @visitors[ip_to_s].nil?
            @visitors[ip_to_s] = 1
          else
            @visitors[ip_to_s] += 1
          end
          @count += 1
        end

        def unique_visitors_count
          @visitors.keys.count
        end
      end
    end
  end
end
