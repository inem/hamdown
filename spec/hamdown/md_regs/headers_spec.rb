require 'spec_helper'

RSpec.describe Hamdown::MdRegs::Headers do
  include_context "text stuff"

  describe 'h1' do
    it 'match words' do
      result = main_text.scan(described_class::REGS['h1']).to_a
      right_result = ["# Main Title", "  # Title"]
      expect(result).to eq(right_result)
    end
  end

  describe 'h2' do
    it 'match words' do
      result = main_text.scan(described_class::REGS['h2']).to_a
      right_result = ["\n  ## Subtitle", "\n    ## Second Subtitle"]
      expect(result).to eq(right_result)
    end
  end

  describe 'h3' do
    it 'match words' do
      result = main_text.scan(described_class::REGS['h3']).to_a
      right_result = ["    ### Subsubbtitle"]
      expect(result).to eq(right_result)
    end
  end

  describe 'h4' do
    it 'match words' do
      result = main_text.scan(described_class::REGS['h4']).to_a
      right_result = ["    #### Subsubsubbtitle"]
      expect(result).to eq(right_result)
    end
  end

  describe 'h5' do
    it 'match words' do
      result = main_text.scan(described_class::REGS['h5']).to_a
      right_result = ["    ##### Subsubsubsubbtitle"]
      expect(result).to eq(right_result)
    end
  end

  describe 'h6' do
    it 'match words' do
      result = main_text.scan(described_class::REGS['h6']).to_a
      right_result = ["    ###### SubSubsubsubsubbtitle"]
      expect(result).to eq(right_result)
    end
  end
end