module Hamdown
  module MdRegs
    # class with logic of markdown's links
    class Links < AbstractReg
      REGS = {
        'link' => /[^!]\[[^\[\]]*?\]\([^\s]*?\)/,
        'link_with_title' => /[^!]\[[^\[\]]*?\]\([^\s]*\s\".*\"\)/
      }.freeze

      private

      # TODO: refactoring
      def text_handler(text, scan_res, reg_name)
        scan_res = scan_res.map { |i| i.lstrip  }
        html_scan = scan_res.map do |i|
          s = ''
          if reg_name == 'link'
            i_text = i.scan(/\[([^\[\]]*?)\]\([^\s]*?\)/).to_a.flatten[0]
            i_href = i.scan(/\[[^\[\]]*?\]\(([^\s]*?)\)/).to_a.flatten[0]
            s = "<a href=\"#{i_href}\">#{escape_html(i_text)}</a>"
          else reg_name == 'link_with_title'
            i_text = i.scan(/\[([^\[\]]*?)\]\([^\s]*\s\".*\"\)/).to_a.flatten[0]
            i_href = i.scan(/\[[^\[\]]*?\]\(([^\s]*)\s\".*\"\)/).to_a.flatten[0]
            i_title = i.scan(/\[[^\[\]]*?\]\([^\s]*\s\"(.*)\"\)/).to_a.flatten[0]
            s = "<a href=\"#{i_href}\" title=\"#{i_title}\">#{escape_html(i_text)}</a>"
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
