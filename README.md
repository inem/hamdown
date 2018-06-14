## Why: To achieve hyper-efficiency when working on static websites.

It is very efficient to use markdown with static site generators, like [Jekyll](https://jekyllrb.com/) or [Middleman](https://middlemanapp.com/). Although, sometimes markdown is not enough. For example, you want to add some custom styling with libraries like [Tachyons](https://tachyons.io/) or [TailwindCSS](https://tailwindcss.com/).

It would be great to write something like this:

```md
# Main Title

%h2.f2.helvetica.strike 
  Fancy title
  **with some bold**

Some content
```

and have it transformed into:

```html
<h1>Main Title</h1>
<h2 class=“f2 helvetica strike”>Fancy title <strong>with some bold</strong></h2>
<p>Some content</p>
```

## Key features: 

1. Support both [Haml](http://haml.info/) and [Markdown](https://en.wikipedia.org/wiki/Markdown) in the same format
2. Built-in [front-matter](https://jekyllrb.com/docs/frontmatter/) support
3. (Optionally) plug common CSS libraries directly from frontmatter
4. Tweak markdown generation rules from frontmatter

### 1. Haml & Markdown together

Hamdown:
```
%section.container
  # Title
  ## Subtitle
  .content
    ![](/images/main.png)
```

Resulting HTML:
```
<section class="container">
<h1>Title</h1>
<h2>Subtitle</h2>
<div class="content">
  <img src="/images/main.png"/>
</div>
</section>
```

### 2. Built-in front-matter support

Now it is handled by static site generators. But I see no reason why it couldn't be a part of Hamdown.

Hamdown:
```
---
title: Colored cars
colors: 
  - blue
  - red
  - black
---
%h1= @title
- @colors.each do |color|
  === ![](/images/#{color}_car.png)
```

Resulting HTML:
```
<h1>Colored cars</h1>
<img src="/images/blue_car.png"/>
<img src="/images/red_car.png"/>
<img src="/images/black_car.png"/>
```


### 3. (Optionally) plug common CSS libraries directly from frontmatter

Hamdown:
```
---
css: tachyons
---

# Hey hey
```

Resulting HTML:
```
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/tachyons/4.9.1/tachyons.min.css">

<h1>Hey hey</h1>
```

### 4. Tweak markdown generation rules from frontmatter

Hamdown:
```
---
defaults: 
  p: .f6.purple.m4.p2
  h2: .f4.red
---

# Title
## Subtitle

Some text

More text
```

Resulting HTML:
```
---
defaults: 
  p: .f6.purple.m4.p2
  h2: .f4.red
---

<h1>Title</h1>
<h2 class="f4 red">Subtitle</h2>

<p class="f6 purple m4 p2">Some text</p>

<p class="f6 purple m4 p2">More text</p>
```

## Current alternatives (suck)

### 1. Plain HTML inside Markdown

```
## Main Title

<h2 class=“f2 courier strike”>Fancy title</h2>

Some content
```

### 2. Template parsers chaining (.md.erb)

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


### 3. Use markdown filters inside Haml

Then you simply use haml as a main format, but switch to markdown when you have big chunks of texts:

```
%h1 Main Title

%h2.f2.courier.strike Fancy title

:markdown
  Some content
```

As you see, all of the options have significant limitations. This is why Hamdown format and generator have to be developed.

## (Self-)Criticism

Some might say that it goes against the idea of content and representation rules separation. It does. 

Although the hypothesis is that this approach would be extremely useful for quick experiments and non-pretentious personal websites.
