# NOTES

Notes of the first implementation

# TODO

## List

### Refactor the code

The code smell and need to be refactored

### Add paragraph support

To implement markdown's paragraph feature (<p> tag)

### To refactor reg_ex in lib/hamdown/md_regs/\*.rb

Each reg_ex should return flat array

### Add nested lists markdown feature

In the current implementation nested list are not supportable

## Prediction errors by parsing text

How to predict errors and print an message as `ParceError: invalid text at line 22.`

## Limitation

### Variables does not support

It does not supports

```haml
- user_id = 123
```

it seems like <li> for MdHandler

```ruby
str = "- user_id = 123\n%a{ href: \"/users/\#{user_id}\" }\n"
```

### Hamlit does not work with nested HTML-tags

It raises an error: `Illegal nesting: nesting within plain text is illegal. (Hamlit::HamlSyntaxError)`

## Resources

- [github mastering-markdown](https://guides.github.com/features/mastering-markdown/)
- [markdowntohtml](https://markdowntohtml.com)
- [haml-converter](https://www.haml-converter.com)
- [markdown reg_exs](https://habr.com/post/190304/)
