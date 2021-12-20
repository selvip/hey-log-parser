# frozen_string_literal: true

require "test_helper"

module Hey
  module Log
    module Parser
      class WebLogListTest < Minitest::Test
        IP1 = "100.100.900.900"
        IP2 = "100.100.100.100"
        PATH1 = "/index"
        PATH2 = "/about"

        def setup
          @web_log_list = Hey::Log::Parser::WebLogList.new
        end

        def test_add_to_list1
          @web_log_list.add_to_list(IP1, PATH1)
          assert_equal list_1_result[:sorted], format_sorted_list(@web_log_list.sorted_list)
          assert_equal list_1_result[:unique_sorted], format_unique_sorted_list(@web_log_list.unique_sorted_list)
        end

        def test_add_to_list2
          @web_log_list.add_to_list(IP1, PATH1)
          @web_log_list.add_to_list(IP1, PATH1)
          assert_equal list_2_result[:sorted], format_sorted_list(@web_log_list.sorted_list)
          assert_equal list_2_result[:unique_sorted], format_unique_sorted_list(@web_log_list.unique_sorted_list)
        end

        def test_add_to_list3
          @web_log_list.add_to_list(IP1, PATH1)
          @web_log_list.add_to_list(IP1, PATH1)
          @web_log_list.add_to_list(IP2, PATH1)
          assert_equal list_3_result[:sorted], format_sorted_list(@web_log_list.sorted_list)
          assert_equal list_3_result[:unique_sorted], format_unique_sorted_list(@web_log_list.unique_sorted_list)
        end

        def test_add_to_list4
          @web_log_list.add_to_list(IP1, PATH1)
          @web_log_list.add_to_list(IP1, PATH1)
          @web_log_list.add_to_list(IP2, PATH1)
          @web_log_list.add_to_list(IP1, PATH2)
          assert_equal list_4_result[:sorted], format_sorted_list(@web_log_list.sorted_list)
          assert_equal list_4_result[:unique_sorted], format_unique_sorted_list(@web_log_list.unique_sorted_list)
        end

        def test_add_to_list5
          @web_log_list.add_to_list(IP1, PATH1)
          @web_log_list.add_to_list(IP1, PATH1)
          @web_log_list.add_to_list(IP2, PATH1)
          @web_log_list.add_to_list(IP1, PATH2)
          @web_log_list.add_to_list(IP2, PATH2)
          assert_equal list_5_result[:sorted], format_sorted_list(@web_log_list.sorted_list)
          assert_equal list_5_result[:unique_sorted], format_unique_sorted_list(@web_log_list.unique_sorted_list)
        end

        private

        def list_1_result
          {
            sorted: { PATH1 => 1 },
            unique_sorted: { PATH1 => 1 }
          }
        end

        def list_2_result
          {
            sorted: { PATH1 => 2 },
            unique_sorted: { PATH1 => 1 }
          }
        end

        def list_3_result
          {
            sorted: { PATH1 => 3 },
            unique_sorted: { PATH1 => 2 }
          }
        end

        def list_4_result
          {
            sorted: { PATH1 => 3, PATH2 => 1 },
            unique_sorted: { PATH1 => 2, PATH2 => 1 }
          }
        end

        def list_5_result
          {
            sorted: { PATH1 => 3, PATH2 => 2 },
            unique_sorted: { PATH1 => 2, PATH2 => 2 }
          }
        end

        def format_sorted_list(list)
          result = {}
          list.each do |line|
            result[line.path] = line.count
          end
          result
        end

        def format_unique_sorted_list(list)
          result = {}
          list.each do |line|
            result[line.path] = line.unique_visitors_count
          end
          result
        end
      end
    end
  end
end
