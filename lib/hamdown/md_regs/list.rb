module Hamdown
  module MdRegs
    # class with logic of markdown's ordered lists
    class List < AbstractReg
      REGS = {
        'list' => /((^ *[\d{1,3}|\*|\+]\.? .*\n?)+)/
      }.freeze

      private

      def text_handler(text, scan_res, reg_name)
        scan_res = scan_res.map{ |i| i[0] }
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
