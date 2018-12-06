RSpec.shared_context "text stuff", :shared_context => :metadata do
  let(:main_text) do
    <<~EOL
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

          ## Second Subtitle
          ### Subsubbtitle
          #### Subsubsubbtitle
          ##### Subsubsubsubbtitle
          ###### SubSubsubsubsubbtitle

          It's very easy to make some words **bold** and other words *italic* with Markdown. And ***bold italic*** You can even [link to Google!](http://google.com)

          Sometimes you want numbered lists:

          1. One
          2. Two
          3. Three

          Sometimes you want bullet points:

          * Start a line with a star
          * Profit!

          Alternatively,

          - Dashes work just as well
          - And if you have sub points, put two spaces before the dash or star:
            - Like this
            - And this

          Inline code:

          I think you should use an `<addr>` element here instead.

          Code block:

          ```javascript
          function fancyAlert(arg) {
            if(arg) {
              $.facebox({div:'#foo'})
            }
          }
          ```

          As Kanye West said:

          > We're living the future so
          > the present is our past.
    EOL
  end
end
