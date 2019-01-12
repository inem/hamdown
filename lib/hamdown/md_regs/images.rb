module Hamdown
  module MdRegs
    # class with logic of markdown's images
    # TODO: rewrite
    class Images < AbstractReg
      REGS = {
        'image' => /!\[[^\[\]]*?\]\(.*?\)/
      }.freeze

      private

      def text_handler(text, scan_res, reg_name)
        html_scan = scan_res.map { |i| md_to_html(i) }
        scan_res.each_with_index do |str, index|
          s = html_scan[index]
          # delete \n at end of string
          text.gsub!(str, s[0..s.size - 2])
        end

        text
      end
    end
  end
end
