module Hamdown
  # module to compile text (haml + html) to html
  # it uses hamlit
  # TODO: need refactoring
  # It use tmp directory 'cos hamlit render data from a file
  module HamlHandler
    def self.perform(haml_text = '')
      return '' if haml_text.size == 0

      html_layout = ''
      file_name = Time.now.to_i.to_s
      file_path = File.join(
        File.dirname(__FILE__),
        "../../tmp/#{file_name}.txt"
      )
      begin
        # save text to file
        file = File.open(file_path, 'w')
        file.puts(haml_text)
        file.close

        # render html
        html_layout = `hamlit render '#{file_path}'`
      rescue StandardError => e
        puts "Error in #{self}#perform"
        puts e.inspect
        puts e.backtrace
      ensure
        # delete file
        if File.exist?(file_path)
          File.delete(file_path)
        end
      end
      return html_layout
    end
  end
end