require 'spec_helper'

RSpec.describe Hamdown::MdRegs::OList do
  include_context "text stuff"

  describe 'o_list' do
    it 'match words' do
      result = main_text.scan(described_class::REGS['o_list']).to_a
      right_result = [
        ["    1. One\n    2. Two\n    3. Three\n", "    3. Three\n"]
      ]
      expect(result).to eq(right_result)
    end
  end
end