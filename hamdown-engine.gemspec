Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=

  s.name = 'hamdown-engine'
  s.version = '0.1.1'
  s.date = '2018-12-11'

  s.description = "Next generation template language for fans of Haml and Markdown"
  s.summary     = s.description
  s.license     = "MIT"

  s.authors = ["Ivan Nemytchenko", "Vlad Kopylov"]
  s.email = "nemytchenko@gmail.com"

  # = MANIFEST =
  s.files = %w[
    bin/hamdown
    lib/hamdown.rb
    lib/hamdown/cli.rb
    lib/hamdown/engine.rb
    lib/hamdown/haml_handler.rb
    lib/hamdown/md_handler.rb
    lib/hamdown/md_regs/abstract_reg.rb
    lib/hamdown/md_regs/code.rb
    lib/hamdown/md_regs/fonts.rb
    lib/hamdown/md_regs/fonts2.rb
    lib/hamdown/md_regs/headers.rb
    lib/hamdown/md_regs/images.rb
    lib/hamdown/md_regs/o_list.rb
    lib/hamdown/md_regs/quotes.rb
    lib/hamdown/md_regs/u_list.rb
  ]
  # = MANIFEST =

  s.executables = ['hamdown']

  s.homepage = "http://github.com/inem/hamdown/"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Hamdown", "--main", "Hamdown"]
  s.require_paths = %w[lib]
  s.rubygems_version = '1.1.1'
end
