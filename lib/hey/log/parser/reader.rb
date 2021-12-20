# frozen_string_literal: true

module Hey
  module Log
    module Parser
      # Rubocop note: This is a file reader and only valid line will be accepted
      class Reader
        def initialize
          @errors = []
          @web_log_list = Hey::Log::Parser::WebLogList.new
        end

        def read_line(line, index)
          result = validate_line(line, index)
          return if result.nil?

          path = result[0]
          ip = result[1]
          @web_log_list.add_to_list(ip, path)
        end

        def error_messages
          @errors.join("\n")
        end

        def check_errors
          if !@errors.empty?
            puts "There are some format errors. Please check config/error_result "
            Hey::Log::Parser::Printer.print("config/error_result", error_messages)
          else
            puts "All good!"
          end
        end

        def validate_line(line, index)
          unless line.is_a?(String)
            @errors << "Invalid line #{index + 1}: Should be a string. "
            return nil
          end
          line.gsub("\n", "")
          result = line.split(" ")
          if result.count != 2
            @errors << "Invalid line #{index + 1}: Should be \"<PATH> <IP ADDRESS>\", e.g: \"\/index 682.704.613.213\" "
            return nil
          end
          unless valid_path?(result[0])
            @errors << "Invalid line #{index + 1}: Path should be like \"\/index\" "
            return nil
          end
          unless valid_ip?(result[1])
            @errors << "Invalid line #{index + 1}: IP should be like \"\/682.704.613.213\" "
            return nil
          end

          result
        end

        def sorted_list_message
          result_message = "Sorted list: "
          @web_log_list.sorted_list.each do |line|
            result_message += " #{line.path} #{line.count},"
          end
          result_message
        end

        def unique_sorted_list_message
          result_message = "Unique sorted list: "
          @web_log_list.unique_sorted_list.each do |line|
            result_message += " #{line.path} #{line.unique_visitors_count},"
          end
          result_message
        end

        def print_sorted_list
          Hey::Log::Parser::Printer.print("config/result", sorted_list_message)
        end

        def print_unique_sorted_list
          Hey::Log::Parser::Printer.print("config/unique_result", unique_sorted_list_message)
        end

        private

        def valid_path?(word)
          %r{^/(\w+$|\w+/\d)}.match(word).to_s == word
        end

        def valid_ip?(word)
          # IP here only check if it is max 3 digit between each dot (not real IP)
          /^\d\d\d\.\d\d\d\.\d\d\d\.\d\d\d$/.match(word).to_s == word
        end
      end
    end
  end
end
