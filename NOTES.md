# NOTES

Notes of the second implementation

# Supported features

Markdown features:

- headers
- text styles
- links
- images
- inline code
- block quotes
- lists and nested lists

# TODO

### Refactor the code

The code inside lib/hamdown/md_regs/\* smell and need to be refactored
All all code should be passed by Rubocop.

### Add paragraph support

To implement markdown's paragraph feature (<p> tag)

## Prediction errors by parsing text

Not sure how to predict errors and print an message as `ParceError: invalid text at line 22.`

## Limitations

## CODE BLOCK

Code block is not supported because it is GitHub-flavored Markdown

## ALTERNATIVE HEADING

It is not supported

## Resources

- [github mastering-markdown](https://guides.github.com/features/mastering-markdown/)
- [markdowntohtml](https://markdowntohtml.com)
- [haml-converter](https://www.haml-converter.com)
- [markdown reg_exs](https://habr.com/post/190304/)
