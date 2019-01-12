require 'markdown'
require 'cgi'
# TODO: escape html with cgi
require_relative 'md_regs/abstract_reg'
require_relative 'md_regs/code'
require_relative 'md_regs/fonts'
require_relative 'md_regs/fonts2'
require_relative 'md_regs/headers'
require_relative 'md_regs/images'
require_relative 'md_regs/o_list'
require_relative 'md_regs/quotes'
require_relative 'md_regs/u_list'

module Hamdown
  # Module to recognize markdown patterns in text and compile it to html/haml
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
