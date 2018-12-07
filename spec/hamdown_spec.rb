require 'spec_helper'

RSpec.describe Hamdown do
  it 'should has version' do
    expect(described_class::VERSION).to_not eq('nil')
  end
end