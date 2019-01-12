require "spec_helper"

RSpec.describe Hamdown::Engine do
  describe 'perform' do
    it 'works with empty string' do
      result = described_class.perform('')
      expect(result).to eq('')
    end

    it 'render html from haml' do
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

    describe 'markdown + haml' do
      it 'can render headers' do
        text = <<~EOL
          ## Hello it is title

          %p
            ## It is second title
            ### And title again
        EOL

        right_result = <<~EOL
          <h2>Hello it is title</h2>
          <p>
          <h2>It is second title</h2>
          <h3>And title again</h3>
          </p>
        EOL

        result = described_class.perform(text)
        expect(result).to eq(right_result)
      end

      it 'can render bold and italic text' do
        text = <<~EOL
          %div
            Some some text with bold **typing lolol** =)
            Some some text with italic *typing lolol* =)
          %p
            *italic again*
            **bold again**
        EOL

        right_result = <<~EOL
          <div>
          Some some text with bold <strong>typing lolol</strong> =)
          Some some text with italic <em>typing lolol</em> =)
          </div>
          <p>
          <em>italic again</em>
          <strong>bold again</strong>
          </p>
        EOL

        result = described_class.perform(text)
        expect(result).to eq(right_result)
      end

      it 'works with monospace' do
        text = <<~EOL
          Some some text with inline code `<addr>` =)

          %div.container
            `12 + 12 / 2`
        EOL

        right_result = <<~EOL
          Some some text with inline code <code>&lt;addr&gt;</code> =)
          <div class='container'>
          <code>12 + 12 / 2</code>
          </div>
        EOL

        result = described_class.perform(text)
        expect(result).to eq(right_result)
      end

      it 'works with code block' do
        text = <<~EOL
          ```ruby
          class A; end
          def foo(i)
            return i + 1
          end
          ```

          %div.container
            ```ruby
            class A; end
            def foo(i)
              return i + 1
            end
            ```
        EOL
        right_result = <<~EOL
          <pre lang=\"ruby\"><code>class A; end&#10;def foo(i)&#10;  return i + 1&#10;end&#10;</code></pre>
          <div class='container'>
          <pre lang=\"ruby\"><code>  class A; end&#10;  def foo(i)&#10;    return i + 1&#10;  end&#10;</code></pre>
          </div>
        EOL

        result = described_class.perform(text)
        expect(result).to eq(right_result)
      end

      it 'works with o_list' do
        text = <<~EOL
          Sometimes you want numbered lists:

          1. One
          2. Two
          3. Three
          4. Four

          Another list

          1. One (B)
          2. Two (B)

          %div.container
            1. One (B2)
            2. Two (B2)
            3. Three (B2)
        EOL

        right_result = <<~EOL
          Sometimes you want numbered lists:
          <ol><li>One</li><li>Two</li><li>Three</li><li>Four</li></ol>
          Another list
          <ol><li>One (B)</li><li>Two (B)</li></ol>
          <div class='container'>
          <ol><li>One (B2)</li><li>Two (B2)</li><li>Three (B2)</li></ol>
          </div>
        EOL

        result = described_class.perform(text)
        expect(result).to eq(right_result)
      end

      it 'works with u_list' do
        text = <<~EOL
          Sometimes you want unnumbered lists:

          * One (A)
          * Two (A)
          * Three (A)

          %div.container
            It can be nested

            %p

              * One (B)
              * Two (B)

            Title

            * One (B2)
            * Two (B2)
            * Three (B2)

          %div.container
            %div.some_class
              And one more

              * Dashes work just as well
              * And if you have sub points, put two spaces before the dash or star
        EOL

        right_result = <<~EOL
          Sometimes you want unnumbered lists:
          <ul><li>One (A)</li><li>Two (A)</li><li>Three (A)</li></ul>
          <div class='container'>
          It can be nested
          <p>
          <ul><li>One (B)</li><li>Two (B)</li></ul>
          </p>
          Title
          <ul><li>One (B2)</li><li>Two (B2)</li><li>Three (B2)</li></ul>
          </div>
          <div class='container'>
          <div class='some_class'>
          And one more
          <ul><li>Dashes work just as well</li><li>And if you have sub points, put two spaces before the dash or star</li></ul>
          </div>
          </div>
        EOL

        result = described_class.perform(text)
        expect(result).to eq(right_result)
      end
    end

    describe 'markdown + haml (advance)' do
      it 'works (case 1)' do
        text = <<~EOL
          # Main Title

          %h2.f2.helvetica.strike
            Fancy title
            **with some bold**

          Some content

          %section.container
            # Title
            ## Subtitle
            .content
              ![](/images/main.png)
        EOL
        right_result = <<~EOL
          <h1>Main Title</h1>
          <h2 class='f2 helvetica strike'>
          Fancy title
          <strong>with some bold</strong>
          </h2>
          Some content
          <section class='container'>
          <h1>Title</h1>
          <h2>Subtitle</h2>
          <div class='content'>
          <p><img src="/images/main.png" alt="" /></p>
          </div>
          </section>
        EOL

        result = described_class.perform(text)
        expect(result).to eq(right_result)
      end

      it 'works (case 2)' do
        text = <<~EOL
          / -------------------------------------------
          / Comments
          / -------------------------------------------

          / This is what a comment looks like in Haml.

          %body
            %header
              # Hello
            %p
              It's very easy to make some words **bold** and other words *italic* with Markdown. You can even [link to Google!](http://google.com)

            %div.main

              * Item 1
              * Item 2

              %div#my_id
                ![GitHub Logo](/images/logo.png)

                1. Item 1
                2. Item 2
                3. Item 3

              %a{:href => '#', :class => 'bar', :title => 'Bar'} Hello
        EOL
        right_result = <<~EOL
          <!-- ------------------------------------------- -->
          <!-- Comments -->
          <!-- ------------------------------------------- -->
          <!-- This is what a comment looks like in Haml. -->
          <body>
          <header>
          <h1>Hello</h1>
          </header>
          <p>
          It's very easy to make some words <strong>bold</strong> and other words <em>italic</em> with Markdown. You can even <a href="http://google.com">link to Google!</a>
          </p>
          <div class='main'>
          <ul><li>Item 1</li><li>Item 2</li></ul>
          <div id='my_id'>
          <p><img src="/images/logo.png" alt="GitHub Logo" /></p>
          <ol><li>Item 1</li><li>Item 2</li><li>Item 3</li></ol>
          </div>
          <a class='bar' href='#' title='Bar'>Hello</a>
          </div>
          </body>
        EOL

        result = described_class.perform(text)
        expect(result).to eq(right_result)
      end
    end
  end
end
