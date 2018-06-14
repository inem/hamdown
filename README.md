## Why: To achieve hyper-efficiency when working on static websites.

It is very efficient to use markdown with static site generators, like Jekyll or Middleman. Although, sometimes markdown is not enough. For example, you want to add some custom styling with libraries like [Tachyons](https://tachyons.io/) or [TailwindCSS](https://tailwindcss.com/).

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

1. Support both Haml and Markdown in the same format
2. Built-in frontmatter support
3. (Optionally) plug common CSS libraries directly from frontmatter
4. Tweak markdown generation rules from frontmatter

Crazy experimental "extensions" ideas:

5. Support charts generation from data in frontmatter
6. Make pages dynamic, by allowing a viewer to (re)define some of the information from frontmatter while viewing the page
7. Make pages aware of their destination on GH/GL/BB, generate and push commits when a checkbox is marked for example
8. Plug public google spreadsheets as data sources

## More Examples



## Current alternatives (suck)

1) **Plain HTML inside Markdown**

```
## Main Title

<h2 class=“f2 courier strike”>Fancy title</h2>

Some content
```

2) **Template parsers chaining (.md.erb)**

Ruby on Rails brought the idea of template parsers chaining. Examples:

With `md.erb` chain you can define and use your own helpers, so your code looks like this:

```
## Main Title

<%= fancy_h2 "Fancy title" %>

Some content
```

Limitations are obvious:

- No easy way to build custom nested HTML structures
- You have to define your helpers in a separate place first


3) **Use markdown filters inside Haml**

Then you simply use haml as a main format, but switch to markdown when you have big chunks of texts:

```
%h1 Main Title

%h2.f2.courier.strike Fancy title

:markdown
  Some content
```

As you see, all of the options have significant limitations. This is why Hamdown format and generator have to be developed.

## (Self-)Criticism

Some might say that it goes against the idea of content and representation rules separation. We admit that. Although it might be extremely useful for quick experiments with 
