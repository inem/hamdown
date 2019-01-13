require 'spec_helper'

RSpec.describe Hamdown::MdRegs::Fonts2 do
  include_context "text stuff"

  describe 'italic' do
    it 'match words' do
      result = main_text.scan(described_class::REGS['italic']).to_a
      right_result = [['*italic*']]
      expect(result).to eq(right_result)
    end
  end

  describe 'monospace' do
    it 'match words' do
      result = main_text.scan(described_class::REGS['monospace']).to_a
      right_result = [['`<addr>`']]
      expect(result).to eq(right_result)
    end
  end
end