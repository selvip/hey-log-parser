# frozen_string_literal: true

require "test_helper"

module Hey
  module Log
    module Parser
      class WebLogTest < Minitest::Test
        IP1 = "100.100.900.900"
        IP2 = "100.100.100.100"
        PATH1 = "/index"

        def setup
          @web_log = Hey::Log::Parser::WebLog.new(ip: IP1, path: PATH1)
        end

        def test_add_count1
          @web_log.add_count(IP1)
          assert_equal 2, @web_log.count
        end

        def test_add_count2
          @web_log.add_count(IP1)
          @web_log.add_count(IP2)
          assert_equal 3, @web_log.count
        end

        def test_unique_visitors_count1
          @web_log.add_count(IP1)
          assert_equal 1, @web_log.unique_visitors_count
        end

        def test_unique_visitors_count2
          @web_log.add_count(IP1)
          @web_log.add_count(IP2)
          assert_equal 2, @web_log.unique_visitors_count
        end
      end
    end
  end
end
