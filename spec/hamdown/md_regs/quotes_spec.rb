require 'spec_helper'

RSpec.describe Hamdown::MdRegs::Quotes do
  include_context "text stuff"

  it 'match words' do
    result = main_text.scan(described_class::REGS['quotes']).to_a
    right_result = [
      [
        "    > We're living the future so\n    > the present is our past.\n",
        "    > the present is our past.\n"
      ]
    ]
    expect(result).to eq(right_result)
  end
end
