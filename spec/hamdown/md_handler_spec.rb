require 'spec_helper'

RSpec.describe Hamdown::MdHandler do
  describe 'h1' do
    it 'can replace it' do
      text = <<~EOL
        # Hello it is title


        # It is second title
      EOL

      right_result = <<~EOL
        <h1>Hello it is title</h1>


        <h1>It is second title</h1>
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end

    it 'can replace nested' do
      text = <<~EOL
        # Hello it is title

        .home_haml
          # It is second title
      EOL

      right_result = <<~EOL
        <h1>Hello it is title</h1>

        .home_haml
          <h1>It is second title</h1>
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end
  end

  describe 'h2' do
    it 'can replace is' do
      text = <<~EOL
        ## Hello it is title


        ## It is second title
      EOL

      right_result = <<~EOL
        <h2>Hello it is title</h2>


        <h2>It is second title</h2>
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end

    it 'can replace nested' do
      text = <<~EOL
        ## Hello it is title

        .home_haml
          ## It is second title
      EOL

      right_result = <<~EOL
        <h2>Hello it is title</h2>

        .home_haml
          <h2>It is second title</h2>
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end
  end

  describe 'h5' do
    it 'can replace it' do
      text = <<~EOL
        ##### Hello it is title <h5>


        ##### It is second title
      EOL

      right_result = <<~EOL
        <h5>Hello it is title &lt;h5&gt;</h5>


        <h5>It is second title</h5>
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end

    it 'can replace nested' do
      text = <<~EOL
        ##### Hello it is title

        .home_haml
          ##### It is second title
      EOL

      right_result = <<~EOL
        <h5>Hello it is title</h5>

        .home_haml
          <h5>It is second title</h5>
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end
  end

  describe 'headers' do
    it 'works with few headers' do
      text = <<~EOL
        # header
        ## header
        ### header
        #### header
      EOL

      right_result = <<~EOL
        <h1>header</h1>
        <h2>header</h2>
        <h3>header</h3>
        <h4>header</h4>
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end
  end

  describe 'bold' do
    it 'replace bold text' do
      text = <<~EOL
        Some some text with bold **<addr> lolol** =)

        **bold again**
      EOL

      right_result = <<~EOL
        Some some text with bold <strong>&lt;addr&gt; lolol</strong> =)

        <strong>bold again</strong>
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end
  end

  describe 'italic' do
    it 'replace italic text' do
      text = <<~EOL
        Some some text with italic *<addr> lolol* =)
        Some some text with italic _typing lolol_ =)

        *italic again*
        _italic again_

        p.p1
          *nested italic again*
          _nested italic again_
      EOL

      right_result = <<~EOL
        Some some text with italic <em>&lt;addr&gt; lolol</em> =)
        Some some text with italic <em>typing lolol</em> =)

        <em>italic again</em>
        <em>italic again</em>

        p.p1
          <em>nested italic again</em>
          <em>nested italic again</em>
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end
  end

  describe 'bold italic' do
    it 'replace italic text' do
      text = <<~EOL
        Some some text with bold italic ***typing lolol*** =)

        ***bold italic again***
      EOL

      right_result = <<~EOL
        Some some text with bold italic <strong><em>typing lolol</em></strong> =)

        <strong><em>bold italic again</em></strong>
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end
  end

  describe 'monospace' do
    it 'replaces text' do
      text = <<~EOL
        Some some text with inline code `<addr>` =)

        `12 + 12 / 2`

        %p
          `12 + 12 / 3`
      EOL

      right_result = <<~EOL
        Some some text with inline code <code>&lt;addr&gt;</code> =)

        <code>12 + 12 / 2</code>

        %p
          <code>12 + 12 / 3</code>
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end
  end

  describe 'monospace with code' do
    it 'replaces text' do
      text = <<~EOL
        Some some text with inline code `<addr>` =)

        ```ruby
        class A; end
        def foo(i)
          return i + 1
        end
        ```

        `12 + 12 / 2`
      EOL

      right_result = <<~EOL
        Some some text with inline code <code>&lt;addr&gt;</code> =)

        <pre lang=\"ruby\"><code>class A; end&#10;def foo(i)&#10;  return i + 1&#10;end&#10;</code></pre>

        <code>12 + 12 / 2</code>
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end

    it 'replaces nested text' do
      text = <<~EOL
        %div.my_class
          ```ruby
          class A; end
          def foo(i)
            return i + 1
          end
          ```
      EOL

      right_result = <<~EOL
        %div.my_class
          <pre lang=\"ruby\"><code>  class A; end&#10;  def foo(i)&#10;    return i + 1&#10;  end&#10;</code></pre>
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end
  end

  describe 'o_list' do
    it 'replace text' do
      text = <<~EOL
        Sometimes you want numbered lists:

        1. One
        2. Two
        3. Three
        4. Four

        div.container
          It can be nested

          1. One (B)
          2. Two (B)

          1. One (B2)
          2. Two (B2)
          3. Three (B2)

        div.container
          div.some_class
            And one more

            1. One (C)
            2. Two (C)
      EOL

      right_result = <<~EOL
        Sometimes you want numbered lists:

        <ol><li>One</li><li>Two</li><li>Three</li><li>Four</li></ol>

        div.container
          It can be nested

          <ol><li>One (B)</li><li>Two (B)</li></ol>

          <ol><li>One (B2)</li><li>Two (B2)</li><li>Three (B2)</li></ol>

        div.container
          div.some_class
            And one more

            <ol><li>One (C)</li><li>Two (C)</li></ol>
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end
  end

  describe 'haml ruby code (with starting dash) remains ruby code' do
    it 'replace text' do
      text = <<~EOL
        - test = 42
        = puts test
      EOL

      right_result = <<~EOL
        - test = 42
        = puts test
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end
  end

  describe 'u_list' do
    it 'replace text' do
      text = <<~EOL
        Sometimes you want unnumbered lists:

        * One (A)
        * Two (A)
        * Three (A)

        div.container
          It can be nested

          * One (B)
          * Two (B)

          Title

          * One (B2)
          * Two (B2)
          * Three (B2)

        div.container
          div.some_class
            And one more

            * Dashes work just as well
            * And if you have sub points, put two spaces before the dash or star
      EOL

      right_result = <<~EOL
        Sometimes you want unnumbered lists:
        <ul><li>One (A)</li><li>Two (A)</li><li>Three (A)</li></ul>

        div.container
          It can be nested
          <ul><li>One (B)</li><li>Two (B)</li></ul>

          Title
          <ul><li>One (B2)</li><li>Two (B2)</li><li>Three (B2)</li></ul>

        div.container
          div.some_class
            And one more
            <ul><li>Dashes work just as well</li><li>And if you have sub points, put two spaces before the dash or star</li></ul>
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end
  end

  describe 'image' do
    it 'replace text' do
      text = <<~EOL
        If you want to embed images, this is how you do it:

        ![Image of Yaktocat](https://octodex.github.com/images/yaktocat.png)
      EOL

      right_result = <<~EOL
        If you want to embed images, this is how you do it:

        <p><img src="https://octodex.github.com/images/yaktocat.png" alt="Image of Yaktocat" /></p>
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end
  end

  describe 'link' do
    it 'replace text' do
      text = <<~EOL
        Hello it is a link to [GitHub](http://github.com)

        div.container
          Hello it is a link to [GitHub](http://github.com#1)

        Hello it is a link to [GitHub](http://github.com)
      EOL

      right_result = <<~EOL
        Hello it is a link to <a href="http://github.com">GitHub</a>

        div.container
          Hello it is a link to <a href="http://github.com#1">GitHub</a>

        Hello it is a link to <a href="http://github.com">GitHub</a>
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end
  end

  describe 'link with title' do
    it 'replace text' do
      text = <<~EOL
        Hello it is a link to [GitHub](http://github.com "Link to Test.com")

        div.container
          Hello it is a link to [GitHub](http://github.com#1 "Link to Test.com")

        Hello it is a link to [GitHub](http://github.com "Link to Test.com")
      EOL

      right_result = <<~EOL
        Hello it is a link to <a href="http://github.com" title="Link to Test.com">GitHub</a>

        div.container
          Hello it is a link to <a href="http://github.com#1" title="Link to Test.com">GitHub</a>

        Hello it is a link to <a href="http://github.com" title="Link to Test.com">GitHub</a>
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end
  end

  describe 'relative link' do
    it 'replace text' do
      text = <<~EOL
        Hello it is a link to [Go to music](/music/)

        div.container
          Hello it is a link to [Go to music](/music/#1)

        Hello it is a link to [Go to music](/music/)
      EOL

      right_result = <<~EOL
        Hello it is a link to <a href="/music/">Go to music</a>

        div.container
          Hello it is a link to <a href="/music/#1">Go to music</a>

        Hello it is a link to <a href="/music/">Go to music</a>
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end
  end

  describe 'quotes' do
    it 'replace text' do
      text = <<~EOL
        As Kanye West said:

        > We are living the future so
        > the present is our past.


        %div.container
          Second quote:

          > Hello, how are you?
          > I am fine!

      EOL

      right_result = <<~EOL
        As Kanye West said:

        <blockquote>   <p>We are living the future so the present is our past.</p> </blockquote>

        %div.container
          Second quote:

          <blockquote>   <p>Hello, how are you? I am fine!</p> </blockquote>
      EOL

      result = described_class.perform(text)
      expect(result).to eq(right_result)
    end
  end
end
