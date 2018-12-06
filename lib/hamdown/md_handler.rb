require 'markdown'
Dir["lib/hamdown/md_regs/*.rb"].each do |f|
  require_relative f.gsub('lib/hamdown/', '')
end

module Hamdown
  # Module to recognize markdown patterns in text and compile it to html
  module MdHandler
    # list of objects with rules:
    # how to recognize markdown patterns by reg_ex
    # how to replace it by html
    OBJECTS = [
      # lists should be before fonts
      MdRegs::OList,
      MdRegs::UList,
      MdRegs::Headers,
      MdRegs::Images,
      MdRegs::Code,
      # font should be before fonts2
      MdRegs::Fonts,
      MdRegs::Fonts2,
      MdRegs::Quotes
    ].freeze

    # render text (haml + html) to html
    def self.perform(text = '')
      OBJECTS.each do |object|
        text = object.new.perform(text)
      end
      text
    end
  end
end
