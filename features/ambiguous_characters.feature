Feature: Ambiguous characters
  Markdown and Haml share some characters for semantics
  Hamdown defines the semantics of those characters
  
  Scenario: Number sign followed or not by a space
  When I render Hamdown
  """
  #person236
    # Person number 236
    The person number 236 is the 236th person.
  """
  
  Then the result is equivalent to
  """
  <div id="person236">
    <h1>Person number 236</h1>
    <p>
      The person number 236 is the 236th person.
    </p>
  </div>
  """
  
  Scenario: Hyphen-minus is a Haml instruction
  When I render Hamdown
  """
  ## Numbers
  - 1
  - 2
  - 3
  - [4,5].each do |n|
    %span= n
  """
  
  Then the result is equivalent to
  """
  <h2>Numbers</h2>
  <span>4</span>
  <span>5</span>
  """
    
