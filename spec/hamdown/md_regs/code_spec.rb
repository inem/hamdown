require 'spec_helper'

RSpec.describe Hamdown::MdRegs::Code do
  include_context "text stuff"

  describe 'code' do
    it 'match words' do
      result = main_text.scan(described_class::REGS['code']).to_a
      right_result = ["```javascript\n    function fancyAlert(arg) {\n      if(arg) {\n        $.facebox({div:'#foo'})\n      }\n    }\n    ```"]
      expect(result).to eq(right_result)
    end
  end
end