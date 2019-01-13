require 'spec_helper'

RSpec.describe Hamdown::MdRegs::Images do
  include_context "text stuff"

  describe 'image' do
    it 'match words' do
      result = main_text.scan(described_class::REGS['image']).to_a
      right_result = ["![](/images/main.png)"]
      expect(result).to eq(right_result)
    end
  end
end
