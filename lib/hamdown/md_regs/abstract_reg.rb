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
        regs_hash.each do |reg_name, reg|
          scan_res = text.scan(reg).to_a
          next if scan_res.size == 0

          text = text_handler(text, scan_res, reg_name)
        end
        text
      end

      private

      def text_handler
        raise 'Does not implemented'
      end

      def regs_arr
        self.class::REGS.values
      end

      def regs_hash
        self.class::REGS
      end

      # split string by \n and prepend ':markdown'
      def prepend_markdown_filter(string)
        str_arr = string.split("\n").map{ |item| "  #{item}\n" }
        mark_line = "#{string.scan(/^[\ ]*/).first}:markdown\n"
        [[mark_line], str_arr].flatten.join('')
      end

      def escape_html(string)
        CGI.escapeHTML(string)
      end
    end
  end
end
