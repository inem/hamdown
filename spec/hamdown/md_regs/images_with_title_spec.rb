require 'spec_helper'

RSpec.describe Hamdown::MdRegs::ImagesWithTitle do
  include_context "text stuff"

  describe 'image_with_title' do
    it 'match words' do
      result = main_text.scan(described_class::REGS['image_with_title']).to_a
      right_result = ["![](/images/main.png \"hello\")"]
      expect(result).to eq(right_result)
    end
  end
end
