module Hamdown
  # CLI module
  # it takes args with file path and return text to STDOUT
  module Cli
    def self.perform(args)
      file_path = args[0]
      if file_path.nil? || file_path.size == 0
        puts 'Error: No file.'
        puts 'Use it like: "bin/hamdown path_to/file.hd > output.html"'
        return nil
      end

      content = File.open(file_path, 'r').read
      output = Machine.perform(content)
      puts output
    end
  end
end
