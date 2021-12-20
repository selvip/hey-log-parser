# frozen_string_literal: true

require "test_helper"
# require "scenario1.log"

module Hey
  module Log
    class ParserTest < Minitest::Test
      def test_that_it_has_a_version_number
        refute_nil ::Hey::Log::Parser::VERSION
      end

      describe "Parser - Read line" do
        before do
          @reader = ::Hey::Log::Parser::Reader.new
        end

        describe "Read line" do
          it "Must read valid line" do
            @reader.read_line("/about 184.123.665.067", 0)
            expect(@reader.sorted_list_message).must_equal "Sorted list:  /about 1,"
            expect(@reader.unique_sorted_list_message).must_equal "Unique sorted list:  /about 1,"
          end

          it "Must not read invalid line - not formatted as: \"<PATH> <IP ADDRESS>\"" do
            @reader.read_line("quick fox", 0)
            expect(@reader.sorted_list_message).must_equal "Sorted list: "
            expect(@reader.unique_sorted_list_message).must_equal "Unique sorted list: "
          end

          it "Must not read invalid line - Different Data Type" do
            @reader.read_line(10_000, 0)
            expect(@reader.sorted_list_message).must_equal "Sorted list: "
            expect(@reader.unique_sorted_list_message).must_equal "Unique sorted list: "
          end

          it "Must not read invalid line - Invalid IP" do
            @reader.read_line("/about 0.100.100.100", 0)
            expect(@reader.sorted_list_message).must_equal "Sorted list: "
            expect(@reader.unique_sorted_list_message).must_equal "Unique sorted list: "
          end

          it "Must not read invalid line - Invalid Path" do
            @reader.read_line("about/ 100.100.100.100", 0)
            expect(@reader.sorted_list_message).must_equal "Sorted list: "
            expect(@reader.unique_sorted_list_message).must_equal "Unique sorted list: "
          end
        end
      end

      describe "Parser - Parsing scenarios" do
        before do
          @reader = ::Hey::Log::Parser::Reader.new
        end

        describe "Parsing scenarios" do
          it "1 log scenario" do
            file_path = "config/parser_test/test1.log"
            file = File.open(file_path)
            index = 0
            file.each do |line|
              @reader.read_line(line, index)
              index += 1
            end
            file.close

            expect(@reader.sorted_list_message).must_equal "Sorted list:  /help_page/1 1,"
            expect(@reader.unique_sorted_list_message).must_equal "Unique sorted list:  /help_page/1 1,"
          end

          it "2 logs scenario" do
            file_path = "config/parser_test/test2.log"
            file = File.open(file_path)
            index = 0
            file.each do |line|
              @reader.read_line(line, index)
              index += 1
            end
            file.close

            expect(@reader.sorted_list_message).must_equal "Sorted list:  /help_page/1 2,"
            expect(@reader.unique_sorted_list_message).must_equal "Unique sorted list:  /help_page/1 2,"
          end

          it "3 logs scenario" do
            file_path = "config/parser_test/test3.log"
            file = File.open(file_path)
            index = 0
            file.each do |line|
              @reader.read_line(line, index)
              index += 1
            end
            file.close

            expect(@reader.sorted_list_message).must_equal "Sorted list:  /help_page/1 2, /index 1,"
            expect(@reader.unique_sorted_list_message).must_equal "Unique sorted list:  /help_page/1 2, /index 1,"
          end

          it "10 logs scenario" do
            file_path = "config/parser_test/test4.log"
            file = File.open(file_path)
            index = 0
            file.each do |line|
              @reader.read_line(line, index)
              index += 1
            end
            file.close

            expect(@reader.sorted_list_message).must_equal "Sorted list:  /about 3, /help_page/1 3, /index 2, /about/1 1, /contact 1,"
            expect(@reader.unique_sorted_list_message).must_equal "Unique sorted list:  /about 3, /help_page/1 3, /index 2, /about/1 1, /contact 1,"
          end
        end
      end

      describe "Parser - Parsing scenarios" do
        before do
          @reader = ::Hey::Log::Parser::Reader.new
        end

        describe "Check errors" do
          it "1 error - scenario" do
            file_path = "config/parser_test/test5.log"
            file = File.open(file_path)
            index = 0
            file.each do |line|
              @reader.read_line(line, index)
              index += 1
            end
            file.close

            expect(@reader.error_messages).must_equal "Invalid line 1: Should be \"<PATH> <IP ADDRESS>\", e.g: \"\/index 682.704.613.213\" "
          end
        end
      end

      # def test
      # end
    end
  end
end
