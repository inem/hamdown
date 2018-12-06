require 'spec_helper'

RSpec.describe Hamdown::MdRegs::UList do
  include_context "text stuff"

  describe 'u_list' do
    it 'match words' do
      result = main_text.scan(described_class::REGS['u_list']).to_a
      right_result = [
        [
          "\n    * Start a line with a star\n    * Profit!\n",
          "    * Profit!\n"
        ],
        [
          "\n    - Dashes work just as well\n    - And if you have sub points, put two spaces before the dash or star:\n      - Like this\n      - And this\n",
          "      - And this\n"
        ]
      ]
      expect(result).to eq(right_result)
    end
  end
end
