# frozen_string_literal: true

require "yaml"
require_relative "parser/version"
require_relative "parser/web_log_list"
require_relative "parser/web_log"
require_relative "parser/reader"
require_relative "parser/printer"

module Hey
  module Log
    # Rubocop note: This is main parser to read the file and parse it
    module Parser
      class Error < StandardError; end
      puts "Start parsing..."

      YAML.load_file("config/env/local_env.yml").each do |key, value|
        ENV[key.to_s] = value
      end

      file_path = "config/webserver.log"

      reader = Hey::Log::Parser::Reader.new
      file = File.open(file_path)
      index = 0
      file.each do |line|
        reader.read_line(line, index)
        index += 1
      end
      file.close

      reader.check_errors
      reader.print_sorted_list
      puts "You can find the result in config/result"
      reader.print_unique_sorted_list
      puts "You can find the result in config/unique_result"
      reader.print_html
      puts "You can find the result in config/result.html"
      puts "Completed"
    end
  end
end
