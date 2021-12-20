# frozen_string_literal: true

module Hey
  module Log
    module Parser
      # Rubocop note: This is to print only
      class Printer
        def self.print(path, message)
          file = File.open(path, "w")
          file.write(message)
          file.close
        end
      end
    end
  end
end
