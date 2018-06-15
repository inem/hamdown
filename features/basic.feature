Feature: Basic Hamdown document

Scenario: A section with headings, a div, an image
  When I render Hamdown 
  """
  %section.container
    # Title
    ## Subtitle
    .content
      ![](/images/main.png)
  """

  Then the result is equivalent to
  """
  <section class="container">
    <h1>Title</h1>
    <h2>Subtitle</h2>
    <div class="content">
      <img src="/images/main.png"/>
    </div>
  </section>
  """
