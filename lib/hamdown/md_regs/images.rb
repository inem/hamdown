module Hamdown
  module MdRegs
    # class with logic of markdown's images
    class Images < AbstractReg
      REGS = {
        'image' => /!\[[^\[\]]*?\]\([^\s]*?\)/,
        'image_with_title' => /!\[[^\[\]]*?\]\([^\s]*\s\".*\"\)/
      }.freeze

      private

      # TODO: refactoring
      def text_handler(text, scan_res, reg_name)
        html_scan = scan_res.map do |i|
          s = ''
          if reg_name == 'image'
            s_src = i.scan(/!\[[^\[\]]*?\]\(([^\s]*)?\)/).to_a.flatten[0]
            s_alt = i.scan(/\[([^\[\]]*?)\]\([^\s]*?\)/).to_a.flatten[0]
            s = "<img src=\"#{s_src}\" alt=\"#{s_alt}\" />"
          elsif reg_name == 'image_with_title'
            s_src = i.scan(/!\[[^\[\]]*?\]\(([^\s]*)\s\".*\"\)/).to_a.flatten[0]
            s_alt = i.scan(/!\[([^\[\]]*?)\]\([^\s]*\s\".*\"\)/).to_a.flatten[0]
            s_title = i.scan(/!\[[^\[\]]*?\]\([^\s]*\s\"(.*)\"\)/).to_a.flatten[0]
            s = "<img src=\"#{s_src}\" alt=\"#{s_alt}\" title=\"#{s_title}\" />"
          end
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
