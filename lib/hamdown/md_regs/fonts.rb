module Hamdown
  module MdRegs
    # class with logic of markdown's bold, link, bold italic text
    class Fonts < AbstractReg
      REGS = {
        'bold' => /(?<!\*|\\\*)[\*|\_]{2,2}[^\*\n_].+?[^\*][\*|\_]{2,2}(?!\*|\\)/,
        'b_italic' => /(?<!\*|\\)\*{3,3}[^\*\n].+?[^\*|\\]\*{3,3}(?!\*)/,
        'b_italic2' => /(?<!\*|\\)\*{2,2}\_{1,1}[^\*\n].+?[^\*|\\]\_{1,1}\*{2,2}(?!\*)/,
        'b_italic3' => /(?<!\*|\\)\*{1,1}\_{2,2}[^\*\n].+?[^\*|\\]\_{2,2}\*{1,1}(?!\*)/,
        'link' => /[^!]\[[^\[\]]*?\]\([^\s]*?\)/,
        'link_with_title' => /[^!]\[[^\[\]]*?\]\([^\s]*\s\".*\"\)/
      }.freeze

      private

      # TODO: escape html with cgi
      def text_handler(text, scan_res, reg_name)
        scan_res = scan_res.map { |i| i.lstrip  }
        html_scan = scan_res.map do |i|
          s = ''
          if reg_name == 'bold'
            s = i.sub(/^\*\*/, '').sub(/\*\*$/, '')
            s = "<strong>#{CGI.escapeHTML(s)}</strong>"
          elsif reg_name == 'b_italic'
            s = i.sub(/^\*\*\*/, '').sub(/\*\*\*$/, '')
            s = "<strong><em>#{CGI.escapeHTML(s)}</em></strong>"
          elsif reg_name == 'b_italic2'
            s = i.sub(/^\*\*\_/, '').sub(/\_\*\*$/, '')
            s = "<strong><em>#{CGI.escapeHTML(s)}</em></strong>"
          elsif reg_name == 'b_italic3'
            s = i.sub(/^\*\_\_/, '')
                  .sub(/\_\_\*$/, '')
            s = "<strong><em>#{CGI.escapeHTML(s)}</em></strong>"
          elsif reg_name == 'link'
            i_text = i.scan(/\[([^\[\]]*?)\]\([^\s]*?\)/).to_a.flatten[0]
            i_href = i.scan(/\[[^\[\]]*?\]\(([^\s]*?)\)/).to_a.flatten[0]
            s = "<a href=\"#{i_href}\">#{CGI.escapeHTML(i_text)}</a>"
          else reg_name == 'link_with_title'
            i_text = i.scan(/\[([^\[\]]*?)\]\([^\s]*\s\".*\"\)/).to_a.flatten[0]
            i_href = i.scan(/\[[^\[\]]*?\]\(([^\s]*)\s\".*\"\)/).to_a.flatten[0]
            i_title = i.scan(/\[[^\[\]]*?\]\([^\s]*\s\"(.*)\"\)/).to_a.flatten[0]
            s = "<a href=\"#{i_href}\" title=\"#{i_title}\">#{CGI.escapeHTML(i_text)}</a>"
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
