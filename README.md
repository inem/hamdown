![Logo](https://i.imgur.com/n8UBf99.png)

## Demo app

https://github.com/kopylovvlad/rails_app_with_hamdown


## Why: To achieve hyper-efficiency when working on static websites

It is very efficient to use Markdown with static site generators, like [Jekyll](https://jekyllrb.com/) or [Middleman](https://middlemanapp.com/). Although, sometimes Markdown is not enough. 

For example, if you might want to add some custom styling with libraries like [Tachyons](https://tachyons.io/) or [TailwindCSS](https://tailwindcss.com/) to a certain element, there is no easy way to do that.

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

The suggestion is to develop a new format called Hamdown to combine the power of both Markdown and Haml.

## Current status

Proposal draft (no implementation yet)


## Key features of Hamdown: 

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

Now, front-matter is handled by static site generators. But I see no reason why it couldn't be a part of Hamdown. This should significantly reduce the amount of work to be done by static site generator, and even remove need in them in simple cases.

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
<h1>Title</h1>
<h2 class="f4 red">Subtitle</h2>

<p class="f6 purple m4 p2">Some text</p>

<p class="f6 purple m4 p2">More text</p>
```

## Current alternatives (suck)

### 1. Plain HTML inside Markdown

```
## Main Title

<h2 class=“f2 helvetica strike”>Fancy title</h2>

Some content
```

You can't do nested markdown inside HTML blocks:
```
<aside class="pic">
  ![](https://i.imgur.com/rZ183q9.png)
</aside>
```

^Markdown inside `<aside>` tag is treated like regular text.

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

Then you simply use haml as the main format, but switch to markdown when you have big chunks of texts:

```
%h1 Main Title

%h2.f2.helvetica.strike Fancy title

:markdown
  Some content
```

As you see, all of the options have significant limitations. This is why Hamdown format and generator have to be developed.

## Challenges

Obviously, there could be some clashes between Haml and Markdown generation rules. The general idea is to treat blocks starting with `.`, `%` like Haml, and blocks starting with `*`, `_`, `#`, `-` (and so on) treat like Markdown.

An example of conflict is "#" symbol. It is used in Haml for `id` attribute, and in Markdown as headers.

A quick solution might be to prohibit ids in Haml part of Hamdown. A smarter solution would be to treat `#person_233 Max` as Haml, and `# Max` as Markdown

Anyway, it makes sense to start with only a subset of Markdown features.

## Roadmap

- [x] Proof of concept implementation of Hamdown
- [x] Describe a minimal subset of Markdown features to implement 
- [x] List all format conflicts and provide solutions
- [x] Develop specs
- [ ] Support nested lists
- [ ] Support code blocks syntax highlighting
- [ ] (?) Frontmatter
- [ ] Proper interface for Tilt
- [ ] Hamdown syntax highlighters for popular editors

## Contribution

You are very welcome to contribute! Whether you'll write a spec, decide to develop a proof of concept of Hamdown, or share an idea of how to approach the development - it all would be very valuable.

Idea author has no experience in template engines development. Although I am willing to educate myself and work on the specification, I don't see myself as the main developer of the Hamdown engine yet.

## Implementation ideas

1. Use [hamlit](https://github.com/k0kubun/hamlit) as a starting point, and implement additional conversion rules for markdown blocks
2. Convert hamdown to [kramdown](https://kramdown.gettalong.org/quickref.html) format, and then simply use kramdown to generate HTML
3. Try Redcarpet Custom Renderers. 
4. [Reuse haml parser](https://github.com/inem/hamdown/issues/6)
5. [Your suggestion](https://github.com/inem/hamdown/issues/new)


## Criticism

> Hamdown goes against the idea of content and representation rules separation. 

It does. Although the hypothesis is that this approach would be extremely useful for quick experiments and non-pretentious personal websites.

> The idea of Markdown to be human-readable, and HAML makes it look awful. 

HAML usage is not the obligation, it is an opportunity. The idea is to provide a cheap way to experiment with look and feel for static websites. With libraries like Tachions it is just a matter of adding a few classes to an element. Once you've finished experimenting, simply update your site-wide CSS rules, and throw away temporary HAML stuff, if needed.

Look at the Clojure. Clojure code might look confusing and weird for an unprepared mind, but no doubts Clojure is a very powerful insrument. In Hamdown we consciously trade a bit of Markdown's elegance for more possibilities.

> You can use plain HTML or ERB if Markdown is not enough

Yes, but HTML closing tags bring too much overhead, and non-trivial constructions take too much visual space, so it stops look like Markdown at all.

> Simply use [kramdown](https://kramdown.gettalong.org/quickref.html)

Yes, it looks like it is possible to achieve similar functionality by chaining Kramdown with ERB (file.md.erb), but it is hard to switch to kramdown, when you're used to HAML.
