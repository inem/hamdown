require 'spec_helper'

RSpec.describe Hamdown::MdRegs::Links do
  include_context "text stuff"

  describe 'link' do
    it 'match words' do
      result = main_text.scan(described_class::REGS['link']).to_a
      right_result = [" [link to Google!](http://google.com)"]
      expect(result).to eq(right_result)
    end
  end
end