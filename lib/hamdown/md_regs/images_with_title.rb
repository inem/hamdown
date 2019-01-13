module Hamdown
  module MdRegs
    # class with logic of markdown's images
    class ImagesWithTitle < AbstractReg
      REGS = {
        'image_with_title' => /!\[[^\[\]]*?\]\([^\s]*\s\".*\"\)/
      }.freeze

      private

      def text_handler(text, scan_res, reg_name)
        html_scan = scan_res.map do |i|
          s = ''
          s_src = i.scan(/!\[[^\[\]]*?\]\(([^\s]*)\s\".*\"\)/).to_a.flatten[0]
          s_alt = i.scan(/!\[([^\[\]]*?)\]\([^\s]*\s\".*\"\)/).to_a.flatten[0]
          s_title = i.scan(/!\[[^\[\]]*?\]\([^\s]*\s\"(.*)\"\)/).to_a.flatten[0]
          s = "<img src=\"#{s_src}\" alt=\"#{s_alt}\" title=\"#{s_title}\" />"
          s
        end
        scan_res.each_with_index do |str, index|
          text.sub!(str, html_scan[index])
        end

        text
      end
    end
  end
end
