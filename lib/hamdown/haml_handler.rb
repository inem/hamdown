require 'haml'
require 'markdown'

module Hamdown
  # module to compile text (haml + html) to html
  module HamlHandler
    def self.perform(haml_text = '')
      return '' if haml_text&.size == 0

      haml_engine = Haml::Engine.new(haml_text)
      html = haml_engine.render

      return html
    end
  end
end