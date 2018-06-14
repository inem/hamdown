## Why: To achieve hyper-efficiency when working on static websites.

It is very efficient to use markdown with static site generators, like Jekyll or Middleman. Although, sometimes markdown is not enough. For example, you want to add some custom styling with libraries like Tachyons or TailwindCSS.

It would be great to write something like this:

```md
# Main Title

%h2.f2.courier.strike Fancy title

Some content
```

and have it transformed into:

```html
<h1>Main Title</h1>
<h2 class=“f2 courier strike”>Fancy title</h2>
<p>Some content</p>
```


## Key features: 

1. Support both Haml and Markdown in the same format.
2. Built-in frontmatter support
3. (Optionally) plug common CSS libraries directly from frontmatter
4. Tweak markdown generation rules from frontmatter

Crazy experimental ideas:

5. Support charts generation from data in frontmatter
6. Make pages dynamic, by allowing a viewer to (re)define some of the information in frontmatter
7. Make pages aware of their destination on GH/GL/BB, generate and push commits when a checkbox is marked for example.
8. Plug public google spreadsheets as data sources

## More Examples



## Current alternatives (suck)

1) plain HTML inside Markdown

2) Template parsers chaining

Ruby on Rails brought the idea of template parsers chaining. Examples:
- file.md.erb
- file.erb.md

3) Another option is to use filters inside Haml
file.haml

All of the options have significant limitations. This is why Hamdown format and generator have to be developed.

## (Self-)Criticism

Some might say that it goes against the idea of content and representation rules separation. We admit that. Although it might be extremely useful for quick experiments with 
