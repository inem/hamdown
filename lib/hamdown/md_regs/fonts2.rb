module Hamdown
  module MdRegs
    # class with logic of markdown's italic and monospace text
    class Fonts2 < AbstractReg
      REGS = {
        'italic' => /((?<!\*|\\)[\*|\_][^\*\n\_].+?[^\*|\\\_][\*|\_](?!\*))/,
        'monospace' => /[^`](`[^`]+`)/
      }.freeze

      private

      def text_handler(text, scan_res, reg_name)
        scan_res = scan_res.map { |i| i[0] }.reject{ |i| i.nil? }
        html_scan = scan_res.map do |i|
          s = ''
          if reg_name == 'italic'
            s = i.sub(/^[\*|\_]/, '')
                 .sub(/[\*|\_]$/, '')
            s = "<em>#{CGI.escapeHTML(s)}</em>"
          elsif reg_name == 'monospace'
            s = i.sub(/^\`/, '')
                 .sub(/\`$/, '')
            s = "<code>#{CGI.escapeHTML(s)}</code>"
          end
          s
        end
        scan_res.each_with_index do |str, index|
          text.gsub!(str, html_scan[index])
        end

        text
      end
    end
  end
end
