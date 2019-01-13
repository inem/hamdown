module Hamdown
  module MdRegs
    # class with logic of markdown's code block
    class Code < AbstractReg
      REGS = {
        'code' => /^[\ ]*```[^`]*```\n?/
      }.freeze

      private

      def text_handler(text, scan_res, reg_name)
        html_scan = scan_res.map do |i|
          prepend_markdown_filter(i)
        end
        scan_res.each_with_index do |str, index|
          text.sub!(str, html_scan[index])
        end

        text
      end
    end
  end
end
