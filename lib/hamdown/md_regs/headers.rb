module Hamdown
  module MdRegs
    # class with logic of markdown's headers
    class Headers < AbstractReg
      REGS = {
        'h1' => /^\s*# .+$/,
        'h2' => /^\s*\#{2,2} .+$/,
        'h3' => /^\s*\#{3,3} .+$/,
        'h4' => /^\s*\#{4,4} .+$/,
        'h5' => /^\s*\#{5,5} .+$/,
        'h6' => /^\s*\#{6,6} .+$/,
      }.freeze

      private

      def text_handler(text, scan_res)
        html_scan = scan_res.map do |i|
          # delete whitespace character
          s = md_to_html(i.gsub(/^\s*/, ''))
          # delete \n at end of line
          if s[-1..-1] == "\n"
            s = s[0..s.size - 2]
          end
          s
        end
        scan_res.each_with_index do |str, index|
          text.sub!(
            str.gsub(/^\s*/, ''),
            html_scan[index]
          )
        end

        text
      end
    end
  end
end
