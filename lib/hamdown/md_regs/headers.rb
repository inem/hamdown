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

      def text_handler(text, scan_res, reg_name)
        html_scan = scan_res.map do |i|
          s = i.sub(/^\s*\#{1,6}\s{1}/, '')
          s = "<#{reg_name}>#{escape_html(s)}</#{reg_name}>"
        end
        scan_res.each_with_index do |str, index|
          text.sub!(
            str.sub(/^\s*/, ''),
            html_scan[index]
          )
        end

        text
      end
    end
  end
end
