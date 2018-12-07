require 'spec_helper'

RSpec.describe Hamdown::MdRegs::Fonts do
  include_context "text stuff"

  describe 'bold' do
    it 'match words' do
      result = main_text.scan(described_class::REGS['bold']).to_a
      right_result = ["**with some bold**", "**bold**"]
      expect(result).to eq(right_result)
    end
  end

  describe 'b_italic' do
    it 'match words' do
      result = main_text.scan(described_class::REGS['b_italic']).to_a
      right_result = ['***bold italic***']
      expect(result).to eq(right_result)
    end
  end

  describe 'link' do
    it 'match words' do
      result = main_text.scan(described_class::REGS['link']).to_a
      right_result = [" [link to Google!](http://google.com)"]
      expect(result).to eq(right_result)
    end
  end
end