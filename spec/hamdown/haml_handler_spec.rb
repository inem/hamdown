require 'spec_helper'

RSpec.describe Hamdown::HamlHandler do

  it 'works with empty string' do
    result = described_class.perform()
    expect(result).to eq('')
  end

  it 'works with haml' do
    text = <<~EOL
      %html
        %head
          %title
            Sativaware : Introduction to HAML
        %body
          Haml is a markup language  ...
          %strong{:class => "code", :id => "message"} Hello, World!
    EOL
    right_result = <<~EOL
      <html>
      <head>
      <title>
      Sativaware : Introduction to HAML
      </title>
      </head>
      <body>
      Haml is a markup language  ...
      <strong class='code' id='message'>Hello, World!</strong>
      </body>
      </html>
    EOL

    result = described_class.perform(text)
    expect(result).to eq(right_result)
  end
end