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

In the current implementation nested lists are not supported

## Prediction errors by parsing text

Not sure how to predict errors and print an message as `ParceError: invalid text at line 22.`

## Limitations

### Hamlit does not work with nested HTML-tags

It raises an error: `Illegal nesting: nesting within plain text is illegal. (Hamlit::HamlSyntaxError)`
Maybe we should use `:plain` filter when there's a need in nested HTML

## Resources

- [github mastering-markdown](https://guides.github.com/features/mastering-markdown/)
- [markdowntohtml](https://markdowntohtml.com)
- [haml-converter](https://www.haml-converter.com)
- [markdown reg_exs](https://habr.com/post/190304/)
