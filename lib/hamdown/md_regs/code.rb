module Hamdown
  module MdRegs
    # class with logic of markdown's code block
    class Code < AbstractReg
      REGS = {
        'code' => /```[^`]*```/
      }.freeze

      private

      def text_handler(text, scan_res, reg_name)
        html_scan = scan_res.map do |i|
          # delete spaces before last '```'
          # and other unused symbols
          s = md_to_html(i.gsub(/ *```$/, '```'))
          s[0..s.size - 2].gsub(/\~*\n/, "\n")
        end
        scan_res.each_with_index do |str, index|
          # replace \n by html symbol
          text.gsub!(str, html_scan[index].gsub("\n", '&#10;'))
        end

        text
      end
    end
  end
end
