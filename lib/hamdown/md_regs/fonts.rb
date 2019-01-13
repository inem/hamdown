module Hamdown
  module MdRegs
    # class with logic of markdown's bold, bold italic text
    class Fonts < AbstractReg
      REGS = {
        'bold' => /(?<!\*|\\\*)[\*|\_]{2,2}[^\*\n_].+?[^\*][\*|\_]{2,2}(?!\*|\\)/,
        'b_italic' => /(?<!\*|\\)\*{3,3}[^\*\n].+?[^\*|\\]\*{3,3}(?!\*)/,
        'b_italic2' => /(?<!\*|\\)\*{2,2}\_{1,1}[^\*\n].+?[^\*|\\]\_{1,1}\*{2,2}(?!\*)/,
        'b_italic3' => /(?<!\*|\\)\*{1,1}\_{2,2}[^\*\n].+?[^\*|\\]\_{2,2}\*{1,1}(?!\*)/
      }.freeze

      private

      # TODO: refactoring
      def text_handler(text, scan_res, reg_name)
        scan_res = scan_res.map { |i| i.lstrip  }
        html_scan = scan_res.map do |i|
          s = ''
          if reg_name == 'bold'
            s = i.sub(/^\*\*/, '').sub(/\*\*$/, '')
            s = "<strong>#{escape_html(s)}</strong>"
          elsif reg_name == 'b_italic'
            s = i.sub(/^\*\*\*/, '').sub(/\*\*\*$/, '')
            s = "<strong><em>#{escape_html(s)}</em></strong>"
          elsif reg_name == 'b_italic2'
            s = i.sub(/^\*\*\_/, '').sub(/\_\*\*$/, '')
            s = "<strong><em>#{escape_html(s)}</em></strong>"
          elsif reg_name == 'b_italic3'
            s = i.sub(/^\*\_\_/, '').sub(/\_\_\*$/, '')
            s = "<strong><em>#{escape_html(s)}</em></strong>"
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
