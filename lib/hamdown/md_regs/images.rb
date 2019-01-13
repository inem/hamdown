module Hamdown
  module MdRegs
    # class with logic of markdown's images
    class Images < AbstractReg
      REGS = {
        'image' => /!\[[^\[\]]*?\]\([^\s]*?\)/
      }.freeze

      private

      def text_handler(text, scan_res, reg_name)
        html_scan = scan_res.map do |i|
          s_src = i.scan(/!\[[^\[\]]*?\]\(([^\s]*)?\)/).to_a.flatten[0]
          s_alt = i.scan(/\[([^\[\]]*?)\]\([^\s]*?\)/).to_a.flatten[0]
          "<img src=\"#{s_src}\" alt=\"#{s_alt}\" />"
        end
        scan_res.each_with_index do |str, index|
          text.sub!(str, html_scan[index])
        end

        text
      end
    end
  end
end
