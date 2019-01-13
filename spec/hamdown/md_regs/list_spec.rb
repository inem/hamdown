require 'spec_helper'

RSpec.describe Hamdown::MdRegs::List do
  include_context "text stuff"

  describe 'o_list' do
    it 'match words' do
      result = main_text.scan(described_class::REGS['list']).to_a
      right_result = [
        ["    1. One\n    2. Two\n    3. Three\n", "    3. Three\n"],
        [
          "    * Start a line with a star\n    * Profit!\n",
          "    * Profit!\n"
        ],
        [
          "    + Dashes work just as well\n    + And if you have sub points, put two spaces before the dash or star:\n      + Like this\n      + And this\n",
          "      + And this\n"
        ]
      ]
      expect(result).to eq(right_result)
    end
  end
end
