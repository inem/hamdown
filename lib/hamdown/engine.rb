require 'hamdown_core'
require_relative 'haml_handler'

module Hamdown
  # Main module
  # Mahine to compile hamdown text to html
  module Engine
    # It takes string with hamdown text and compile it to html
    def self.perform(hd_text = '')
      return '' if hd_text.size == 0

      # step 1: hamdown to haml
      haml_text = HamdownCore::Engine.call(hd_text)

      # step 2: haml to html
      html_text = HamlHandler.perform(haml_text)
      return html_text
    end
  end
end
