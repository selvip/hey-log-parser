# frozen_string_literal: true

require_relative "web_log"

module Hey
  module Log
    module Parser
      # Rubocop note: WebLogList acts as List object
      class WebLogList
        def initialize
          @list = []
        end

        def sorted_list
          @list.sort_by(&:count).reverse
        end

        def unique_sorted_list
          @list.sort_by(&:unique_visitors_count).reverse
        end

        def add_to_list(ip, path)
          web_log = find_web_log(path)
          if web_log.nil?
            web_log = Hey::Log::Parser::WebLog.new(ip: ip, path: path)
            @list << web_log
          else
            web_log.add_count(ip)
          end
        end

        private

        def find_web_log(path)
          result = @list.select { |log| log.path == path }
          result.empty? ? nil : result.first
        end
      end
    end
  end
end
