module Hamdown
  module MdRegs
    # class with logic of markdown's ordered lists
    # TODO: add nested lists support
    class OList < AbstractReg
      # TODO: add '?:' to unuseful group /learn(?:bydoing)/
      REGS = {
        'o_list' => /((^ *\d{1,3}\. .*\n)+)/
      }.freeze

      private

      def text_handler(text, scan_res)
        # crazy manipulation
        scan_res = scan_res.map { |i| i[0] }
        html_scan = scan_res
                    .map { |i| i.gsub(/^ */, '') }
                    .map { |i| i.gsub(/\n( )*/, "\n")}
                    .map { |i| md_to_html(i) }

        html_scan = html_scan
                    .map { |i| i.split(/\n */).join('') }
                    .map { |i| "#{i}\n" }
        scan_res.each_with_index do |str, index|
          space_size = str.scan(/^ */)[0].size
          html = html_scan[index].split(/\n/).join("\n#{' ' * space_size}")
          html = "#{' ' * space_size}#{html}\n"
          text.gsub!(str, html)
        end
        text
      end
    end
  end
end
