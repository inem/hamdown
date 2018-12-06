module Hamdown
  module MdRegs
    # class with logic of markdown's quotes
    class Quotes < AbstractReg
      # TODO: add '?:' to unuseful group /learn(?:bydoing)/
      REGS = {
        'quotes' => /((^\s*>{1,4} .+\n)+)/
      }.freeze

      private

      def text_handler(text, scan_res)
        # crazy manipulation
        scan_res = scan_res.map{ |i| i[0] }
        html_scan = scan_res.map do |i|
          md_to_html(i)
        end
        scan_res.each_with_index do |str, index|
          space_size = str.scan(/^\n( *)\>/)[0][0].size
          html = html_scan[index]
                  .split(/\n/)
                  .select { |i| i.size > 0 }
                  .join(' ')
          text.gsub!(str, "\n#{' ' * space_size}#{html}")
        end

        text
      end
    end
  end
end
