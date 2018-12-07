require 'markdown'

module Hamdown
  module MdRegs
    # Abstract class
    # each child should consist logic how to
    # recognize markdown's pattern
    # and how to replace it to html
    # it uses markdown gem
    class AbstractReg
      REGS = {}

      def perform(text = '')
        regs_arr.each do |reg|
          scan_res = text.scan(reg).to_a
          next if scan_res.size == 0

          text = text_handler(text, scan_res)
        end
        text
      end

      private

      def text_handler
        raise 'Does not implemented'
      end

      def md_to_html(text = '')
        Markdown.new(text, banner: false).to_html
      end

      def regs_arr
        self.class::REGS.values
      end
    end
  end
end