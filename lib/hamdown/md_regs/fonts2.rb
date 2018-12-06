module Hamdown
  module MdRegs
    # class with logic of markdown's italic and monospace text
    class Fonts2 < AbstractReg
      # TODO: add '?:' to unuseful group /learn(?:bydoing)/
      REGS = {
        'italic' => /((?<!\*|\\)\*[^\*\n].+?[^\*|\\]\*(?!\*))|(_.+?_)/,
        'monospace' => /[^`](`[^`]+`)/
      }.freeze

      private

      def text_handler(text, scan_res)
        scan_res = scan_res.map { |i| i[0] }.reject{ |i| i.nil? }
        html_scan = scan_res.map do |i|
          s = md_to_html(i)
          # delete <p> in start and end of line
          s = s[3, s.size]
          s = s[0..s.size - 6]
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
